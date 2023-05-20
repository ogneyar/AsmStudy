
TOOL_CHAIN			:= E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin
PREFIX				:= riscv-none-embed-
OCD		 			:= E:\Program\MounRiver/MounRiver_Studio/toolchain/OpenOCD/bin/openocd
OPENOCD_CFG 		:= ../libs/Util/wch-riscv.cfg

BUILD_DIR	:= build

CH_MAP_LD		:= ../libs/Ld/ch32v00x_map.ld


FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
OBJ			:= $(BUILD_DIR)/$(FILE_NAME).o
ELF			:= $(BUILD_DIR)/$(FILE_NAME).elf
HEX			:= $(BUILD_DIR)/$(FILE_NAME).hex
BIN			:= $(BUILD_DIR)/$(FILE_NAME).bin


all: flash
	@echo finish All
	
flash: obj
	@$(OCD) -f $(OPENOCD_CFG)  -c init -c halt  -c "program $(HEX)" -c wlink_reset_resume -c exit

obj: link
	@$(TOOL_CHAIN)\$(PREFIX)objcopy -O binary $(ELF) $(BIN)
	@$(TOOL_CHAIN)\$(PREFIX)objcopy -O ihex $(ELF) $(HEX)

link: compile
	@$(TOOL_CHAIN)\$(PREFIX)ld -T $(CH_MAP_LD) -o $(ELF) $(OBJ)

compile:
	@if not exist $(BUILD_DIR) (mkdir $(BUILD_DIR))
	@$(TOOL_CHAIN)\$(PREFIX)as.exe -o $(OBJ) $(ASM)

# openocd -s E:\Program\OpenOCD\share\openocd\scripts -f interface\stlink.cfg -f target\stm32f1x.cfg -c "program main.elf" -c "verify_image main.elf" -c reset -c resume -c exit
# openocd -s E:\Program\OpenOCD\share\openocd\scripts -f interface\stlink.cfg -f target\stm32f1x.cfg 
# -c "set _CPUTAPID 0x2ba01477" -c "transport select hla_swd" -c "reset_config none"

# openocd -f ../libs/stlink.cfg -f ../libs/stm32f1x.cfg -c "program build/main.elf" -c "verify_image build/main.elf" -c reset -c resume -c exit
