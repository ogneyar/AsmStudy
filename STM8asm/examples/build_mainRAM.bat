set STM8ASM_DIR=D:\stm\_toolchain\stm8_asm
set STM8ASM_INCLUDE_DIR=D:\stm\_toolchain\stm8_asm\include
set PATH=%STM8ASM_DIR%;%STM8ASM_INCLUDE_DIR%
@echo on
:: Сборка файла STM8S103F3P.asm...
 asm -sym -li=list\STM8S103F3P.lsr %STM8ASM_INCLUDE_DIR%\STM8S103F3P.asm -I=%STM8ASM_INCLUDE_DIR%  -obj=obj\STM8S103F3P.obj
:: Сборка файла Assembling mainRAM.asm...
asm -sym -li=list\mainRAM.lsr mainRAM.asm -I=%STM8ASM_INCLUDE_DIR%  -obj=obj\mainRAM.obj
:: Линковка файлов STM8S103F3P.obj и mainRAM.obj в файл mainRAM.cod
lyn obj\STM8S103F3P.obj+obj\mainRAM.obj, bin\mainRAM.cod, ; 
:: Создание файлов прошивки mainRAM.hex и mainRAM.s19
obsend bin\mainRAM.cod,f,bin\mainRAM.hex,ix
obsend bin\mainRAM.cod,f,bin\mainRAM.s19,s
pause
