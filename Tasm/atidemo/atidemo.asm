;*********************************************************************************
;*				������ �������������� ������ � ATI GPU 	 	                     *
;* ���� �� ������� ��������� GPU ����� ATI128. ���� ������� ������ ��� �������   *														
;* ����������� �� ���������, �� ������ ��� � ����� ��� �� shamukov@mail.ru 	     *																	
;* Shm, 10.03.11																 *	
;*********************************************************************************
.model small
.stack 100h
.data
vesa_err1 DB 'Error VESA initialization', 0Ah, 0Dh, '$'
vesa_err2 DB 'VBE mode not supported', 0Ah, 0Dh, '$'
pci_err DB 'ATI VGA not found', 0Ah, 0Dh, '$'
vesa_lfb dd ? ;���������� ����� ����������� (������������ ������ ��� �������� ����������� �������)
ati_mmio dd ? ;���������� ����� ����� ��������� ������������ �� ������
ati_devid dw ? ;����������� ������ ��������� ����������
ati_avivo db 0 ;������� ������������ ����������� ����������� ����� ���� AVIVO ���������
old_rnd dd ? ;��������������� ���������� ��� ��������� ��������������� �����
current_draw db 0 ;��� ����� ��������: 0 - ��������� �����, 1 - ��������� ��������������
timer dd 0 ;����� �������� �� ��������� ����� � ��������� ���������������
hcur_x dw 0 ;���������� X ��������� ����������� �������
hcur_y dw 0 ;���������� Y ��������� ����������� �������
hcur_x_dir db 0 ;����������� �������� ������� �� X
hcur_y_dir db 0 ;����������� �������� ������� �� Y
hcur_timer dd 0 ;����� ����������� �������
.code
.586 
;��������� ����������� ������ � ������ ������
SCREEN_WIDTH	equ 800
SCREEN_HEIGHT	equ 600
;����������� ������� ��������� ����� ��� ������������ ������������
HCUR_IMAGE_BASE	equ SCREEN_WIDTH*SCREEN_HEIGHT*4
;����� ����� ������ ��������� (����� ��� ��������������, �������� 2 ���.)
REPLACE_DELAY	equ 36

;����������� ������������ � ���� ��������� ��������� (����� �� ����������� ��������, ���������� ������ � ��������)
RADEON_CUR_OFFSET						equ 00260h ;�������� ����������� ������� � �����������
RADEON_CUR_HORZ_VERT_POSN				equ 00264h ;������� ������� 
RADEON_CUR_HORZ_VERT_OFF				equ 00268h ;�������� ������ ��������� ������� ���� ������������ �����������
RADEON_CRTC_GEN_CNTL					equ 0050h ;������� ���������� CRTC (��� ���������� ������ ���������� ������)
;	���������� � VESA ������� �������������
	RADEON_CRTC_DBL_SCAN_EN				equ (1 shl  0)
	RADEON_CRTC_INTERLACE_EN			equ (1 shl  1)
	RADEON_CRTC_CSYNC_EN				equ (1 shl  4)
	RADEON_CRTC_ICON_EN					equ (1 shl 15)
	RADEON_CRTC_CUR_EN					equ (1 shl 16) ;��������� ���������� ���������� ������
	RADEON_CRTC_CUR_MODE_MASK			equ (7 shl 20) ;�������� ������ ����������� �������
	RADEON_CRTC_EXT_DISP_EN				equ (1 shl 24)
	RADEON_CRTC_EN						equ (1 shl 25)
	RADEON_CRTC_DISP_REQ_EN_B			equ (1 shl 26)
RADEON_RBBM_STATUS						equ 00E40h
	RADEON_RBBM_FIFOCNT_MASK			equ 0007Fh ;���������� ���������� ��������� ������ GPU
	
RADEON_DEFAULT_SC_BOTTOM_RIGHT			equ 016E8h ;���������� ���������� ������� ���������
	RADEON_DEFAULT_SC_RIGHT_MAX			equ (01FFFh shl 0)
	RADEON_DEFAULT_SC_BOTTOM_MAX		equ (01FFFh shl 16)
RADEON_DP_BRUSH_BKGD_CLR				equ 01478h ;���� ����
RADEON_DP_BRUSH_FRGD_CLR				equ 0147Ch ;���� �����
RADEON_DP_SRC_BKGD_CLR					equ 015DCh ;���� ���� ���������
RADEON_DP_SRC_FRGD_CLR					equ 015D8h ;���� ���������
RADEON_DP_WRITE_MASK					equ	016CCh ;������ ���������� �����-�����������
RADEON_DST_PITCH_OFFSET					equ	0142Ch ;���������� ������ ������ ����������
RADEON_SRC_PITCH_OFFSET					equ 01428h ;���������� ������ ������ ���������
RADEON_DP_CNTL							equ 016C0h ;����������� ���������
	RADEON_DST_X_LEFT_TO_RIGHT			equ (1 shl  0)
	RADEON_DST_Y_TOP_TO_BOTTOM			equ (1 shl  1)
	RADEON_DP_DST_TILE_LINEAR			equ (0 shl  3)
	RADEON_DP_DST_TILE_MACRO			equ (1 shl  3)
	RADEON_DP_DST_TILE_MICRO			equ (2 shl  3)
	RADEON_DP_DST_TILE_BOTH				equ (3 shl  3)
;�����: ���������� x � y, ������ � ������ ����� ������������ ������� � ������� � ������� ������ 32-������� ��������
;� ������� � ������� ����� RADEON_DST_LINE_START ���������� x, � ������� ����� y.
RADEON_DST_LINE_PATCOUNT				equ 01608h ;������������ ��������� �����
RADEON_DST_LINE_START					equ 01600h ;��������� ������ �����
RADEON_DST_LINE_END						equ 01604h ;���������� ����� ����� (����� ������ � ���� ������� GPU ������
;	���������� ��������)
RADEON_DP_GUI_MASTER_CNTL				equ 0146Ch ;������� ���������� ������� ���������, ��� ������ ����� ���������� �
;	�������� �������� "Radeon R5xx Acceleration"
RADEON_DST_Y_X							equ	01438h ;��������� ������� ��������� 
RADEON_DST_WIDTH_HEIGHT					equ	01598h ;������ � ������ ������� ���������
;� ������� ���� ���������������� ��������� �������� ������ ��������� (���������)
RADEON_SC_TOP_LEFT						equ 016ECh ;���������� ������ �������������� �����������
RADEON_SC_BOTTOM_RIGHT					equ 016F0h ;���������� ����� �������������� �����������

;�������� ������������ ���������� AVIVO, �� ������ ����� ���������� � �������� �������� "RV630Register Reference Guide"
AVIVO_D1CRTC_H_TOTAL					equ 06000h ;������ ������ ��������� ������ � �������� - 1 (������������ ��� ����������� 
;	��������� ������������ AVIVO)
AVIVO_D1CUR_SURFACE_ADDRESS             equ 06408h ;�������� ����������� ������� � �����������
AVIVO_D1CUR_POSITION					equ 06414h ;������� ������� 
AVIVO_D1CUR_SIZE                        equ 06410h ;������ �������
AVIVO_D1CUR_CONTROL                     equ 06400h ;�������� ����������� ��������
	AVIVO_D1CURSOR_EN					equ	(1 shl 0) ;��������� ���������� ���������� ������
	AVIVO_D1CURSOR_MODE_SHIFT			equ 8 ;�������� ������ ����������� ������� 

;��������� ���������� ������� �� unreal.obj � vesamode.obj, ����� �� ������������ ���. ��� ������������� �� ��� ����� 
;������� �������� �������� ��� �������� ��������.
;������� ������������� � ��������� ����������� (� LFB) ����� VESA BIOS, �����-���� ������������ �� �����.  
extrn _SetVesaVideoMode:near
extrn _InitVesa:near
;������������� "�����������" ������ �� �86 (������ � ���������� ������ ����� GS)
extrn _unreal_init:near

start:
	mov  ax, @data
	mov  ds, ax
	
	call find_ati_vga ;����� ATI VGA �� ���� PCI
	call _unreal_init ;���������������� "����������" �����
	
	call _InitVesa ;��������������� ��������� VBE
	test AX, AX
	jnz @@ok1
	;��� �������� VESA BIOS
	mov	DX, offset vesa_err1
	mov	AH, 9
	int	21h
	jmp @@exit
@@ok1:
	;���������� ���������� TrueColor32
	push word ptr  32
	push word ptr SCREEN_HEIGHT
	push word ptr SCREEN_WIDTH
	call _SetVesaVideoMode
	add SP, 6
	test DX, DX ; ������� � ������ ����� ���������� � DX:AX LFB, ������� ���� DX = 0, �� ����� �� ��������������
	jnz @@ok2
	mov	DX, offset vesa_err2
	mov	AH, 9
	int	21h
	jmp @@exit
@@ok2:
	;�������� LFB � ���������� vesa_lfb
	lea BX, vesa_lfb
	mov [BX], AX
	mov [BX + 2], DX
	;����������� ��������� ������������ AVIVO
	;���� ��� ���������, �� D1CRTC_H_TOTAL = 0, ����� D1CRTC_H_TOTAL = SCREEN_WIDTH - 1
	mov EBX, [ati_mmio]
	mov EAX, GS:[EBX + AVIVO_D1CRTC_H_TOTAL]
	test EAX, EAX
	jz @@no_avivo
	mov [ati_avivo], 1 ;������������� ���� ��������� ������������ AVIVO
@@no_avivo:	
	call radeon_hcur_init ;������������� ����������� �������
	call radeon_init_2d_engine ;������������� ����� 2D � ������ PIO (��� DMA ���� AGP GART ���������������) 
	
;������� ���� ���������
;���������� ��� ������������ ����������� � ������������� ��������� ��������� ����� � ���������������,
;� ����� ����������� ������� � ���� ��������������� ��������������� ���������� �������� 64�64
;����������� ����� ��������� ����� ��������������, �� ��� ���� - ������������������ ������ � GPU �� ������� �������
@@main_loop:
	;����������� ����������� ������� �� ������
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
	call radeon_hcur_set_pos ;��������� ������ � ����� �������

@@no_hcur_set_pos:
	mov EAX, 5
	call radeon_wait_fifo ;������� ������������ 5 ��������� ������
	;�������� GP �� ��������� ��������� ������ � ���������� �������� 
	;(��������� �������� ����� ����� �������� �������� � "Radeon R5xx Acceleration")
	;������ � ������ ��������� ���������� ��������  ����� �������� ������� ���������� ��������� 2� �������
	mov dword ptr GS:[EBX + RADEON_DP_GUI_MASTER_CNTL], 10F036DAh
	mov EAX, [old_rnd]
	;������������� ���� �����
	mov GS:[EBX + RADEON_DP_BRUSH_FRGD_CLR], EAX
	
	test [current_draw], 1 ;���������� ���� ����� ��������
	jnz @@dr2
	
	;������ �����
	call get_xy
	mov GS:[EBX + RADEON_DST_LINE_START], ECX ;������� ���������� ������
	call get_xy
	mov GS:[EBX + RADEON_DST_LINE_END], ECX ; � ����� (GPU ����� �������� ���������)
	jmp short @@end_dr
	
@@dr2:
	;������ �������������	
	call get_xy
	mov GS:[EBX + RADEON_DST_Y_X], ECX ;������� ���������� ������
	call get_xy
	mov GS:[EBX + RADEON_DST_WIDTH_HEIGHT], ECX ;������� ������ � ������ (GPU ����� �������� ���������)
	;������ ����� ������������ ������ �������������� � ������ ������ ������ �� ����� ������, 
	;�� GPU ����� - ��� �������, ����� �� ����� ���������� ��� ������������� ������� "������������" � ������ �������
;���������� ����� ������������ ��������� ����� � ���������������
@@end_dr:
	mov EAX, GS:[046Ch]
	cmp [timer], EAX
	ja @@no_switch_dr
	add EAX, REPLACE_DELAY
	mov [timer], EAX
	xor [current_draw], 1
@@no_switch_dr:
	;���� ������ ESC, �� ������� �� ���������
	mov AH, 01h
	int 16h
	jz @@main_loop
	xor AH, AH
	int 16h
	xor AH, 1 
	jnz @@main_loop
	;������������� ����������� ��������� �����
	mov AX, 3
	int 10h
@@exit:
	mov	ax,4C00h
	int	21h

;����� ������� ������������� ATI �� ���� PCI
;������� ���������� PCI BIOS
find_ati_vga:
	xor SI, SI
@@next:
	mov AX, 0B103h
	mov ECX, 030000h
	int 1Ah ;����� ���������� �� ���� ������
	jnc @@notend
	jmp @@notfound
@@notend:
	inc SI
	mov AX, 0B109h
	xor DI, DI
	int 1Ah ;������ ������������� ������������
	xor CX, 1002h ;��� AMD? 
	jz @@found
	test SI, 10h ;���������� ������ 16 �������� � ����� �������
	jz @@next
;ATI VGA �� ������
@@notfound:
	mov	DX, offset pci_err
	mov	AH, 9
	int	21h
	jmp @@exit
@@found:
	mov DI, 2
	int 1Ah
	mov [ati_devid], CX ;��������� ������������� ����������
	mov AX, 0B10Ah
	mov DI, 18h
	int 1Ah ;������ ���������� ����� ����� ��������� MMIO  
	and ECX, not 0FFh
	jz @@next ;���������� �� ����������������
	mov [ati_mmio], ECX ;��������� ���������� ����� ����� ��������� MMIO 
	ret

;������������� ����������� �������
radeon_hcur_init:
;�������� ����������� �������. ��� ������� ������������ ����������� ������� ����, �� ����� �� ������������ ��� ��������
;������������ ��������� ����������� ����������� ������ �������������� ��������� �������, ��� ������ ������ ��� �� ������.
	mov EBX, [vesa_lfb]
	add EBX, HCUR_IMAGE_BASE
	mov EAX, 0A0FF8000h ;���� � ������� ARGB32 
	mov CX, 64*64
@@put_cur_pix:
	mov GS:[EBX], EAX
	add EBX, 4
	loop @@put_cur_pix
	
	mov EBX, [ati_mmio]
	test [ati_avivo], 1 ;������� ������������ AVIVO?
	jnz @@avivo_cur_init
	mov dword ptr GS:[EBX + RADEON_CUR_OFFSET], HCUR_IMAGE_BASE ;������������� �������� ����������� ������� � �����������
	mov AX,[hcur_y]
	shl EAX, 16
	mov AX, [hcur_x]
	mov GS:[EBX + RADEON_CUR_HORZ_VERT_POSN], EAX ;������������� ��������� ����������
	mov dword ptr GS:[EBX + RADEON_CUR_HORZ_VERT_OFF], 0 ;������������� ������������ ������ ������� 64�64
	;�������� ���������� ������ ����� ������� ���������� CRTC
	mov EAX, GS:[EBX + RADEON_CRTC_GEN_CNTL]
	and EAX, not RADEON_CRTC_CUR_MODE_MASK
	or EAX, RADEON_CRTC_CUR_EN or (2 shl 20);��������� ��������� ������� � �������� �������� ����� ARGB32
	mov GS:[EBX + RADEON_CRTC_GEN_CNTL], EAX
	ret
;������������� ������� ����� AVIVO ��������
@@avivo_cur_init:
	mov EAX, HCUR_IMAGE_BASE
	add EAX, [vesa_lfb]
	mov GS:[EBX + AVIVO_D1CUR_SURFACE_ADDRESS], EAX ;������������� �������� ����������� ������� � �����������
	mov AX,[hcur_y]
	shl EAX, 16
	mov AX, [hcur_x]
	mov GS:[EBX + AVIVO_D1CUR_POSITION], EAX ;������������� ��������� ����������
	mov dword ptr GS:[EBX + AVIVO_D1CUR_SIZE], (63 shl 16) or 63 ;������������� ������������ ������ ������� 64�64
	;��������� ��������� ������� � �������� �������� ����� ARGB32 
	mov dword ptr GS:[EBX + AVIVO_D1CUR_CONTROL], AVIVO_D1CURSOR_EN or (2 shl AVIVO_D1CURSOR_MODE_SHIFT)
	ret

;���������� ���������� ����������� �������
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

;�������� ������������ ������� ���������� ��������� ������
;EAX - ����� ������
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

;������������� ����� 2D � ������ PIO
radeon_init_2d_engine:
	mov EBX, [ati_mmio]
	
	;������������� ������������ �������� ����� 2D GPU
	mov dword ptr GS:[EBX + RADEON_DEFAULT_SC_BOTTOM_RIGHT], RADEON_DEFAULT_SC_RIGHT_MAX or RADEON_DEFAULT_SC_BOTTOM_MAX
	mov EAX, 5
	call radeon_wait_fifo
	mov dword ptr GS:[EBX + RADEON_DP_BRUSH_FRGD_CLR], 0
	mov dword ptr GS:[EBX + RADEON_DP_BRUSH_BKGD_CLR], 0
	mov dword ptr GS:[EBX + RADEON_DP_SRC_FRGD_CLR], 0
	mov dword ptr GS:[EBX + RADEON_DP_SRC_BKGD_CLR], 0
	;��������� ������������ ������������ �����-���������� (�.�. ���������� ��� ���������)
	mov dword ptr GS:[EBX + RADEON_DP_WRITE_MASK], 0FFFFFFFFh
	mov EAX, 6
	call radeon_wait_fifo
	;��������� ���������� ������ ������ ��������� � ��������� � ������, �� ����� ��������, ��� GPU �������� ��������
	;�� ����������� CRTC 
	mov dword ptr GS:[EBX + RADEON_DST_PITCH_OFFSET], (SCREEN_WIDTH*4 / 64) shl 22
	mov dword ptr GS:[EBX + RADEON_SRC_PITCH_OFFSET], (SCREEN_WIDTH*4 / 64) shl 22
	;����������� ���������: ������ ����, ����� �������
	mov dword ptr GS:[EBX + RADEON_DP_CNTL], RADEON_DST_X_LEFT_TO_RIGHT or RADEON_DST_Y_TOP_TO_BOTTOM
	mov dword ptr GS:[EBX + RADEON_DST_LINE_PATCOUNT], 5500h
	;������������� ��������� �� ����� ������
	mov dword ptr GS:[EBX + RADEON_SC_TOP_LEFT], (0 shl 16) or 0
	mov dword ptr GS:[EBX + RADEON_SC_BOTTOM_RIGHT], ( (SCREEN_HEIGHT - 1) shl 16 ) or (SCREEN_WIDTH - 1) 
	ret
;�������� ��������������� ����������� x, y � ������ ������
;������� ���������� � ������� ����� ECX ���������� x, � ������� - y 	
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

