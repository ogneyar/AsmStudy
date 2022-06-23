;*********************************************************************************
;*				Пример низкоуровневой работы с ATI GPU 	 	                     *
;* Пока не сделана поддержка GPU серии ATI128. Если увидели ошибку или имеются   *														
;* предложения по доработке, то пишите мне в личку или на shamukov@mail.ru 	     *																	
;* Shm, 10.03.11																 *	
;*********************************************************************************
.model small
.stack 100h
.data
vesa_err1 DB 'Error VESA initialization', 0Ah, 0Dh, '$'
vesa_err2 DB 'VBE mode not supported', 0Ah, 0Dh, '$'
pci_err DB 'ATI VGA not found', 0Ah, 0Dh, '$'
vesa_lfb dd ? ;физический адрес видеопамяти (используется только для загрузки изображения курсора)
ati_mmio dd ? ;физический адрес блока регистров отображаемых на память
ati_devid dw ? ;инефикатоор модели найденого устройства
ati_avivo db 0 ;признак графического контроллера работающего через блок AVIVO регистров
old_rnd dd ? ;вспомогательная переменная для генерации псевдослучайных чисел
current_draw db 0 ;что сечас рисуется: 0 - случайные линии, 1 - случайные прямоугольники
timer dd 0 ;время перехода от рисований линий к рисованию прямоугольников
hcur_x dw 0 ;координата X положения аппаратного курсора
hcur_y dw 0 ;координата Y положения аппаратного курсора
hcur_x_dir db 0 ;направление движения курсора по X
hcur_y_dir db 0 ;направление движения курсора по Y
hcur_timer dd 0 ;время перемещения курсора
.code
.586 
;константы испльзуемой ширины и высоты экрана
SCREEN_WIDTH	equ 800
SCREEN_HEIGHT	equ 600
;изображение курсора находится прямо под отображаемой видеопямятью
HCUR_IMAGE_BASE	equ SCREEN_WIDTH*SCREEN_HEIGHT*4
;время смены режима рисования (линии или прямоугольники, примерно 2 сек.)
REPLACE_DELAY	equ 36

;определения используемых в этой программе регистров (взяты из линуксового драйвера, собственно больше и неоткуда)
RADEON_CUR_OFFSET						equ 00260h ;смещения изображения курсора в видеопамяти
RADEON_CUR_HORZ_VERT_POSN				equ 00264h ;позиция курсора 
RADEON_CUR_HORZ_VERT_OFF				equ 00268h ;смещение начала отрисовки курсора мыши относительно изображание
RADEON_CRTC_GEN_CNTL					equ 0050h ;регистр управления CRTC (нас интересует только аппаратный курсор)
;	видеорижим и VESA неплохо конфигурирует
	RADEON_CRTC_DBL_SCAN_EN				equ (1 shl  0)
	RADEON_CRTC_INTERLACE_EN			equ (1 shl  1)
	RADEON_CRTC_CSYNC_EN				equ (1 shl  4)
	RADEON_CRTC_ICON_EN					equ (1 shl 15)
	RADEON_CRTC_CUR_EN					equ (1 shl 16) ;разрешить отображать аппаратный курсор
	RADEON_CRTC_CUR_MODE_MASK			equ (7 shl 20) ;цветовая модель изображения курсора
	RADEON_CRTC_EXT_DISP_EN				equ (1 shl 24)
	RADEON_CRTC_EN						equ (1 shl 25)
	RADEON_CRTC_DISP_REQ_EN_B			equ (1 shl 26)
RADEON_RBBM_STATUS						equ 00E40h
	RADEON_RBBM_FIFOCNT_MASK			equ 0007Fh ;количество свободдных командных слотов GPU
	
RADEON_DEFAULT_SC_BOTTOM_RIGHT			equ 016E8h ;глобальные координаты области обрезания
	RADEON_DEFAULT_SC_RIGHT_MAX			equ (01FFFh shl 0)
	RADEON_DEFAULT_SC_BOTTOM_MAX		equ (01FFFh shl 16)
RADEON_DP_BRUSH_BKGD_CLR				equ 01478h ;цвет фона
RADEON_DP_BRUSH_FRGD_CLR				equ 0147Ch ;цвет кисти
RADEON_DP_SRC_BKGD_CLR					equ 015DCh ;цвет фона источника
RADEON_DP_SRC_FRGD_CLR					equ 015D8h ;цвет источника
RADEON_DP_WRITE_MASK					equ	016CCh ;регист управления альфа-смешиванием
RADEON_DST_PITCH_OFFSET					equ	0142Ch ;логическая ширина строки получателя
RADEON_SRC_PITCH_OFFSET					equ 01428h ;логическая ширина строки источника
RADEON_DP_CNTL							equ 016C0h ;направление отрисовки
	RADEON_DST_X_LEFT_TO_RIGHT			equ (1 shl  0)
	RADEON_DST_Y_TOP_TO_BOTTOM			equ (1 shl  1)
	RADEON_DP_DST_TILE_LINEAR			equ (0 shl  3)
	RADEON_DP_DST_TILE_MACRO			equ (1 shl  3)
	RADEON_DP_DST_TILE_MICRO			equ (2 shl  3)
	RADEON_DP_DST_TILE_BOTH				equ (3 shl  3)
;ВАЖНО: координаты x и y, ширина и высота могут передаваться попарно в младшей и старшей частях 32-битного регистра
;к примеру в мнадшей части RADEON_DST_LINE_START передается x, в старшей части y.
RADEON_DST_LINE_PATCOUNT				equ 01608h ;корректирока отрисовки линий
RADEON_DST_LINE_START					equ 01600h ;кординаты начала линии
RADEON_DST_LINE_END						equ 01604h ;координаты конца линии (после записи в этот регистр GPU начнет
;	выпосление операции)
RADEON_DP_GUI_MASTER_CNTL				equ 0146Ch ;регистр управления текущей операцией, его формат можно посмотреть в
;	открытом даташите "Radeon R5xx Acceleration"
RADEON_DST_Y_X							equ	01438h ;кординаты области отрисовки 
RADEON_DST_WIDTH_HEIGHT					equ	01598h ;ширина и высота области отрисовки
;с помощью двух нижеопределенных регистров задается регион отрисовки (обрезание)
RADEON_SC_TOP_LEFT						equ 016ECh ;координыты начала прямоугольника отображения
RADEON_SC_BOTTOM_RIGHT					equ 016F0h ;координыты конца прямоугольника отображения

;регистры определенные станадртом AVIVO, их формат можно посмотреть в открытом даташите "RV630Register Reference Guide"
AVIVO_D1CRTC_H_TOTAL					equ 06000h ;ширина строки развертки экрана в пикселах - 1 (используется для определения 
;	поддержки контроллером AVIVO)
AVIVO_D1CUR_SURFACE_ADDRESS             equ 06408h ;смещения изображения курсора в видеопамяти
AVIVO_D1CUR_POSITION					equ 06414h ;позиция курсора 
AVIVO_D1CUR_SIZE                        equ 06410h ;размер курсора
AVIVO_D1CUR_CONTROL                     equ 06400h ;рекгистр управлениея курсором
	AVIVO_D1CURSOR_EN					equ	(1 shl 0) ;разрешить отображать аппаратный курсор
	AVIVO_D1CURSOR_MODE_SHIFT			equ 8 ;цветовая модель изображения курсора 

;Объвление глобальных функций из unreal.obj и vesamode.obj, чтобы не загромождать код. При необходимости вы без труда 
;сможите отыскать исходный код подобных процедур.
;Функции инициализации и установки видеорежима (с LFB) через VESA BIOS, каких-либо особенностей не имеют.  
extrn _SetVesaVideoMode:near
extrn _InitVesa:near
;инициализация "нереального" режима ЦП х86 (доступ к физической памяти через GS)
extrn _unreal_init:near

start:
	mov  ax, @data
	mov  ds, ax
	
	call find_ati_vga ;найти ATI VGA на шине PCI
	call _unreal_init ;инициализировать "нереальный" режим
	
	call _InitVesa ;инициализровать параметры VBE
	test AX, AX
	jnz @@ok1
	;нет поддержи VESA BIOS
	mov	DX, offset vesa_err1
	mov	AH, 9
	int	21h
	jmp @@exit
@@ok1:
	;установить видеорежим TrueColor32
	push word ptr  32
	push word ptr SCREEN_HEIGHT
	push word ptr SCREEN_WIDTH
	call _SetVesaVideoMode
	add SP, 6
	test DX, DX ; функция в случае удачи возвращает в DX:AX LFB, поэтому если DX = 0, то режим не поддерживается
	jnz @@ok2
	mov	DX, offset vesa_err2
	mov	AH, 9
	int	21h
	jmp @@exit
@@ok2:
	;сохраним LFB в переменной vesa_lfb
	lea BX, vesa_lfb
	mov [BX], AX
	mov [BX + 2], DX
	;определение поддержки контроллером AVIVO
	;если нет поддержки, то D1CRTC_H_TOTAL = 0, иначе D1CRTC_H_TOTAL = SCREEN_WIDTH - 1
	mov EBX, [ati_mmio]
	mov EAX, GS:[EBX + AVIVO_D1CRTC_H_TOTAL]
	test EAX, EAX
	jz @@no_avivo
	mov [ati_avivo], 1 ;устанавливаем флаг поддержки контроллером AVIVO
@@no_avivo:	
	call radeon_hcur_init ;инициализация аппаратного курсора
	call radeon_init_2d_engine ;инициализация блока 2D в режиме PIO (для DMA надо AGP GART программировать) 
	
;главный цикл программы
;собственно вся демонстрация заключается в переодическом рисовании случайных линий и прямоугольников,
;а также аппаратного курсора в виде перемещающегося полупрозрачного оранжевого квадрата 64х64
;желающеющие могут придумать нечто пооригинальней, но моя цель - продемонстрировать работу с GPU на простом примере
@@main_loop:
	;перемещение аппаратного курсора по экрану
	mov EAX, GS:[046Ch]
	cmp [hcur_timer], EAX
	ja @@no_hcur_set_pos
	inc EAX
	mov [hcur_timer], EAX

	call get_xy 
	and CX, 15
	test [hcur_x_dir], 1
	jz @@update_hcur_x
	neg CX
@@update_hcur_x:
	add [hcur_x], CX
	rol ECX, 16
	and CX, 15
	test [hcur_y_dir], 1
	jz @@update_hcur_y
	neg CX
@@update_hcur_y:
	add [hcur_y], CX
	
	cmp [hcur_x], SCREEN_WIDTH - 64
	jbe @@hcur_select_y_dir
	xor [hcur_x_dir], 1
	jnz @@hcur_cross_x_b
	mov [hcur_x], 0
	jmp short @@hcur_select_y_dir
@@hcur_cross_x_b:
	mov [hcur_x], SCREEN_WIDTH - 64
@@hcur_select_y_dir:
	cmp [hcur_y], SCREEN_HEIGHT - 64
	jbe @@hcur_set_pos
	xor [hcur_y_dir], 1
	jnz @@hcur_cross_y_b
	mov [hcur_y], 0
	jmp short @@hcur_set_pos
@@hcur_cross_y_b:
	mov [hcur_y], SCREEN_HEIGHT - 64
@@hcur_set_pos:	
	call radeon_hcur_set_pos ;установим курсор в новую позицию

@@no_hcur_set_pos:
	mov EAX, 5
	call radeon_wait_fifo ;ожидаем освобождения 5 командных слотов
	;настроим GP на отрисовку примитива кистью с монотонной заливкой 
	;(подробное описание полей этого регистра смотрите в "Radeon R5xx Acceleration")
	;вообще с момощь различных комбинаций значений  можно получить большое количество различных 2Д функций
	mov dword ptr GS:[EBX + RADEON_DP_GUI_MASTER_CNTL], 10F036DAh
	mov EAX, [old_rnd]
	;устанавливаем цвет кисти
	mov GS:[EBX + RADEON_DP_BRUSH_FRGD_CLR], EAX
	
	test [current_draw], 1 ;определяем чего будем рисовать
	jnz @@dr2
	
	;рисуем линию
	call get_xy
	mov GS:[EBX + RADEON_DST_LINE_START], ECX ;заносим координаты начала
	call get_xy
	mov GS:[EBX + RADEON_DST_LINE_END], ECX ; и конца (GPU сразу начинает отрисовку)
	jmp short @@end_dr
	
@@dr2:
	;рисуем прямоугольник	
	call get_xy
	mov GS:[EBX + RADEON_DST_Y_X], ECX ;заносим координаты начала
	call get_xy
	mov GS:[EBX + RADEON_DST_WIDTH_HEIGHT], ECX ;заносим ширину и высоту (GPU сразу начинает отрисовку)
	;вообще брать произвольную ширину прямоугольника в рамках ширины экрана не очень хорошо, 
	;но GPU умный - сам обрежет, чтобы на экран уместилось без нежелательных эфектов "переползания" с другой стороны
;определяем время переключения рисования линий и прямоугольников
@@end_dr:
	mov EAX, GS:[046Ch]
	cmp [timer], EAX
	ja @@no_switch_dr
	add EAX, REPLACE_DELAY
	mov [timer], EAX
	xor [current_draw], 1
@@no_switch_dr:
	;если нажата ESC, то выходим из программы
	mov AH, 01h
	int 16h
	jz @@main_loop
	xor AH, AH
	int 16h
	xor AH, 1 
	jnz @@main_loop
	;устанавливаем стандартный текстовый режим
	mov AX, 3
	int 10h
@@exit:
	mov	ax,4C00h
	int	21h

;поиск первого видеоадаптера ATI на шине PCI
;функция использует PCI BIOS
find_ati_vga:
	xor SI, SI
@@next:
	mov AX, 0B103h
	mov ECX, 030000h
	int 1Ah ;поиск устройства по коду класса
	jnc @@notend
	jmp @@notfound
@@notend:
	inc SI
	mov AX, 0B109h
	xor DI, DI
	int 1Ah ;читаем идентификатор изготовителя
	xor CX, 1002h ;это AMD? 
	jz @@found
	test SI, 10h ;опрашиваем первые 16 устройтв с таким классом
	jz @@next
;ATI VGA не найден
@@notfound:
	mov	DX, offset pci_err
	mov	AH, 9
	int	21h
	jmp @@exit
@@found:
	mov DI, 2
	int 1Ah
	mov [ati_devid], CX ;сохраняем идентификатор устройства
	mov AX, 0B10Ah
	mov DI, 18h
	int 1Ah ;читаем физический адрес блока регистров MMIO  
	and ECX, not 0FFh
	jz @@next ;устройство не сконфигурировано
	mov [ati_mmio], ECX ;сохраняем физический адрес блока регистров MMIO 
	ret

;инициализация аппаратного курсора
radeon_hcur_init:
;Загрузка изображения курсора. Как правило используется изображение курсора мыши, но чтобы не загромождать код массивом
;определяющим растровое изображения загружается просто полупрозрачный оранжевый квадрат, ибо логики работы это не меняет.
	mov EBX, [vesa_lfb]
	add EBX, HCUR_IMAGE_BASE
	mov EAX, 0A0FF8000h ;цвет в формате ARGB32 
	mov CX, 64*64
@@put_cur_pix:
	mov GS:[EBX], EAX
	add EBX, 4
	loop @@put_cur_pix
	
	mov EBX, [ati_mmio]
	test [ati_avivo], 1 ;адаптер поддерживает AVIVO?
	jnz @@avivo_cur_init
	mov dword ptr GS:[EBX + RADEON_CUR_OFFSET], HCUR_IMAGE_BASE ;устанавливаем смещения изображения курсора в видеопамяти
	mov AX,[hcur_y]
	shl EAX, 16
	mov AX, [hcur_x]
	mov GS:[EBX + RADEON_CUR_HORZ_VERT_POSN], EAX ;устанавливаем начальные координаты
	mov dword ptr GS:[EBX + RADEON_CUR_HORZ_VERT_OFF], 0 ;устанавливаем максимальный размер курсора 64х64
	;разрешим аппаратный курсор через регистр управления CRTC
	mov EAX, GS:[EBX + RADEON_CRTC_GEN_CNTL]
	and EAX, not RADEON_CRTC_CUR_MODE_MASK
	or EAX, RADEON_CRTC_CUR_EN or (2 shl 20);разрешаем отрисовку курсора и выбираем цветовой режим ARGB32
	mov GS:[EBX + RADEON_CRTC_GEN_CNTL], EAX
	ret
;инициализация курсора через AVIVO регистры
@@avivo_cur_init:
	mov EAX, HCUR_IMAGE_BASE
	add EAX, [vesa_lfb]
	mov GS:[EBX + AVIVO_D1CUR_SURFACE_ADDRESS], EAX ;устанавливаем смещения изображения курсора в видеопамяти
	mov AX,[hcur_y]
	shl EAX, 16
	mov AX, [hcur_x]
	mov GS:[EBX + AVIVO_D1CUR_POSITION], EAX ;устанавливаем начальные координаты
	mov dword ptr GS:[EBX + AVIVO_D1CUR_SIZE], (63 shl 16) or 63 ;устанавливаем максимальный размер курсора 64х64
	;разрешаем отрисовку курсора и выбираем цветовой режим ARGB32 
	mov dword ptr GS:[EBX + AVIVO_D1CUR_CONTROL], AVIVO_D1CURSOR_EN or (2 shl AVIVO_D1CURSOR_MODE_SHIFT)
	ret

;установить координаты аппаратного курсора
radeon_hcur_set_pos:
	push EAX
	mov AX, [hcur_x]
	shl EAX, 16
	mov AX, [hcur_y]
	test [ati_avivo], 1
	jnz @@avivo_hcur_set_pos
	mov GS:[EBX + RADEON_CUR_HORZ_VERT_POSN], EAX
	pop EAX
	ret 
@@avivo_hcur_set_pos:
	mov GS:[EBX + AVIVO_D1CUR_POSITION], EAX
	pop EAX
	ret 

;ожидание освобождения нужного количества командных слотов
;EAX - число слотов
radeon_wait_fifo:
	push ECX
	push EDX
	mov ECX, 2000000
@@fifo_wait:
	mov EDX, GS:[EBX + RADEON_RBBM_STATUS]
	and EDX, RADEON_RBBM_FIFOCNT_MASK
	cmp EDX, EAX
	jae @@firo_free
	loop @@fifo_wait
@@firo_free:
	pop EDX
	pop ECX
	ret

;инициализация блока 2D в режиме PIO
radeon_init_2d_engine:
	mov EBX, [ati_mmio]
	
	;устанавливаем оперделенные значения блока 2D GPU
	mov dword ptr GS:[EBX + RADEON_DEFAULT_SC_BOTTOM_RIGHT], RADEON_DEFAULT_SC_RIGHT_MAX or RADEON_DEFAULT_SC_BOTTOM_MAX
	mov EAX, 5
	call radeon_wait_fifo
	mov dword ptr GS:[EBX + RADEON_DP_BRUSH_FRGD_CLR], 0
	mov dword ptr GS:[EBX + RADEON_DP_BRUSH_BKGD_CLR], 0
	mov dword ptr GS:[EBX + RADEON_DP_SRC_FRGD_CLR], 0
	mov dword ptr GS:[EBX + RADEON_DP_SRC_BKGD_CLR], 0
	;установим максимальные коэффициенты альфа-смешивания (т.е. фактически его отключаем)
	mov dword ptr GS:[EBX + RADEON_DP_WRITE_MASK], 0FFFFFFFFh
	mov EAX, 6
	call radeon_wait_fifo
	;установка логической ширины строки источника и приемника в байтах, не стоит забывать, что GPU работает отдельно
	;от контроллера CRTC 
	mov dword ptr GS:[EBX + RADEON_DST_PITCH_OFFSET], (SCREEN_WIDTH*4 / 64) shl 22
	mov dword ptr GS:[EBX + RADEON_SRC_PITCH_OFFSET], (SCREEN_WIDTH*4 / 64) shl 22
	;направление отрисовки: сверху вниз, слева направо
	mov dword ptr GS:[EBX + RADEON_DP_CNTL], RADEON_DST_X_LEFT_TO_RIGHT or RADEON_DST_Y_TOP_TO_BOTTOM
	mov dword ptr GS:[EBX + RADEON_DST_LINE_PATCOUNT], 5500h
	;устанавливаем обрезание по всему экрану
	mov dword ptr GS:[EBX + RADEON_SC_TOP_LEFT], (0 shl 16) or 0
	mov dword ptr GS:[EBX + RADEON_SC_BOTTOM_RIGHT], ( (SCREEN_HEIGHT - 1) shl 16 ) or (SCREEN_WIDTH - 1) 
	ret
;получить псевдослучайные корординаты x, y в рамках экрана
;функция возвращает в младшей части ECX координату x, в старшей - y 	
get_xy:
	push EBX
	DB 0Fh, 31h ;RDTSC
	xor EDX, EDX
	xor EAX, [old_rnd]
	neg EAX
	mov EBX, SCREEN_HEIGHT
	div EBX
	mov ECX, EDX
	rol [old_rnd], cl
	DB 0Fh, 31h ;RDTSC
	xor EDX, EDX
	xor EAX, [old_rnd]
	mov [old_rnd], EAX
	mov EBX, SCREEN_WIDTH	
	div EBX
	shl ECX, 16
	mov CX, DX
	ror [old_rnd], cl
	pop EBX
	ret
	


end  start

