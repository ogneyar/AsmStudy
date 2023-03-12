
all:
	@E:\Program\arm-gnu-toolchain\bin\arm-none-eabi-as.exe -o main.o main.asm
	@E:\Program\arm-gnu-toolchain\bin\arm-none-eabi-ld.exe -T stm32f10x_map.ld -o main.elf main.o
	@E:\Program\arm-gnu-toolchain\bin\arm-none-eabi-objcopy.exe -O binary main.elf main.bin
	@E:\Program\arm-gnu-toolchain\bin\arm-none-eabi-objcopy.exe -O ihex main.elf main.hex
	