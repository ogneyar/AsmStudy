@echo off
CLS

:: Удалим файлы прежних попыток сборки проекта
del /Q compile\*.* 
del /Q compile\temp\*.* 

:: Компиляция
bin\arm-none-eabi-as.exe -o compile\temp\sys.o main.asm
:: Если при компиляции были ошибки и выходного файла нет - выходим !
SET st=compile\temp\sys.o
IF NOT exist %st% (
echo Ошибка при компиляции !
exit
)
:: Выполняем линковку 
bin\arm-none-eabi-ld.exe -T stm32f40_map.ld -o compile\temp\sys.elf compile\temp\sys.o
:: Если при линковке были ошибки и выходного файла нет - выходим !
SET st=compile\temp\sys.elf
IF NOT exist %st% (
echo Ошибка при линковке секций !
exit
)
:: Выделяем из .elf файла - файлы прошивки .bin и .hex 
bin\arm-none-eabi-objcopy.exe -O binary compile\temp\sys.elf compile\output.bin
bin\arm-none-eabi-objcopy.exe -O ihex   compile\temp\sys.elf compile\output.hex

:: Информация о секциях
bin\arm-none-eabi-size.exe compile\temp\sys.o -A -d
bin\arm-none-eabi-objdump compile\temp\sys.o -h > compile\temp\sections.lst

:: Отдельно информация о каждой секции в файл (вывод в файлы)
bin\arm-none-eabi-objdump.exe  -j .text -d -t -w compile\temp\sys.o > compile\temp\main_text.lst

:: Адреса меток и значения переменных, вывод в файл
bin\arm-none-eabi-nm.exe -A -p compile\temp\sys.elf > compile\temp\labels.lst

echo Файлы прошивки находятся в папке \compile\
