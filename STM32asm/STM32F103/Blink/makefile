
TOOL_CHAIN			:= E:\Program\arm-gnu-toolchain\bin
OPENOCD_SCRIPTS		:= E:\Program\OpenOCD\share\openocd\scripts
OPENOCD_INTERFACE	:= interface\stlink.cfg
OPENOCD_TARGET		:= target\stm32f1x.cfg

BUILD_DIR	:= build

STM_MAP_LD		:= ../libs/stm32f10x_map.ld

FILE_NAME	:= main
ASM			:= $(FILE_NAME).asm
OBJ			:= $(BUILD_DIR)/$(FILE_NAME).o
ELF			:= $(BUILD_DIR)/$(FILE_NAME).elf
HEX			:= $(BUILD_DIR)/$(FILE_NAME)_stm32f10x.hex
BIN			:= $(BUILD_DIR)/$(FILE_NAME)_stm32f10x.bin


all: flash
	@echo Finish All
	
flash: obj
	@openocd -s $(OPENOCD_SCRIPTS) -f $(OPENOCD_INTERFACE) -f $(OPENOCD_TARGET) -c "program $(ELF)" -c "verify_image $(ELF)" -c reset -c resume -c exit

obj: link
	@$(TOOL_CHAIN)\arm-none-eabi-objcopy.exe -O binary $(ELF) $(BIN)
	@$(TOOL_CHAIN)\arm-none-eabi-objcopy.exe -O ihex $(ELF) $(HEX)

link: compile
	@$(TOOL_CHAIN)\arm-none-eabi-ld.exe -T $(STM_MAP_LD) -o $(ELF) $(OBJ)

compile:
	@if not exist $(BUILD_DIR) (mkdir $(BUILD_DIR))
	@$(TOOL_CHAIN)\arm-none-eabi-as.exe -o $(OBJ) $(ASM)

# openocd -s E:\Program\OpenOCD\share\openocd\scripts -f interface\stlink.cfg -f target\stm32f1x.cfg -c "program main.elf" -c "verify_image main.elf" -c reset -c resume -c exit
# openocd -s E:\Program\OpenOCD\share\openocd\scripts -f interface\stlink.cfg -f target\stm32f1x.cfg 
# -c "set _CPUTAPID 0x2ba01477" -c "transport select hla_swd" -c "reset_config none"
