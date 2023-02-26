set STM8ASM_DIR=D:\stm\_toolchain\stm8_asm
set STM8ASM_INCLUDE_DIR=D:\stm\_toolchain\stm8_asm\include
set PATH=%STM8ASM_DIR%;%STM8ASM_INCLUDE_DIR%
@echo on
:: Сборка файла STM8S103F3P.asm...
 asm -sym -li=list\STM8S103F3P.lsr %STM8ASM_INCLUDE_DIR%\STM8S103F3P.asm -I=%STM8ASM_INCLUDE_DIR%  -obj=obj\STM8S103F3P.obj
:: Сборка файла Assembling mainFLASH.asm...
asm -sym -li=list\mainFLASH.lsr mainFLASH.asm -I=%STM8ASM_INCLUDE_DIR%  -obj=obj\mainFLASH.obj
:: Линковка файлов STM8S103F3P.obj и mainFLASH.obj в файл mainFLASH.cod
lyn obj\STM8S103F3P.obj+obj\mainFLASH.obj, bin\mainFLASH.cod, ; 
:: Создание файлов прошивки mainFLASH.hex и mainFLASH.s19
obsend bin\mainFLASH.cod,f,bin\mainFLASH.hex,ix
obsend bin\mainFLASH.cod,f,bin\mainFLASH.s19,s
pause
