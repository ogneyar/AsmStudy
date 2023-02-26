set STM8ASM_DIR=D:\stm\_toolchain\stm8_asm
set STM8ASM_INCLUDE_DIR=D:\stm\_toolchain\stm8_asm\include
set PATH=%STM8ASM_DIR%;%STM8ASM_INCLUDE_DIR%
@echo on
:: Сборка файла STM8S103F3P.asm...
 asm -sym -li=list\STM8S103F3P.lsr %STM8ASM_INCLUDE_DIR%\STM8S103F3P.asm -I=%STM8ASM_INCLUDE_DIR%  -obj=obj\STM8S103F3P.obj
:: Сборка файла Assembling main_F_v25.asm...
asm -sym -li=list\main_F_v25.lsr main_F_v25.asm -I=%STM8ASM_INCLUDE_DIR%  -obj=obj\main_F_v25.obj
:: Линковка файлов STM8S103F3P.obj и main_F_v25.obj в файл main_F_v25.cod
lyn obj\STM8S103F3P.obj+obj\main_F_v25.obj, bin\main_F_v25.cod, ; 
:: Создание файлов прошивки main_F_v25.hex и main_F_v25.s19
obsend bin\main_F_v25.cod,f,bin\main_F_v25.hex,ix
obsend bin\main_F_v25.cod,f,bin\main_F_v25.s19,s
pause
