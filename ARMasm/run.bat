as -o example.o example.s
ld -Ttext=0x0 -o example.elf example.o
objcopy -O binary example.elf example.bin