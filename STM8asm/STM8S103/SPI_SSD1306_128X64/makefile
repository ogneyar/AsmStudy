
#ASM_DIR		:= E:\VSCode\AsmStudy\STMasm\program\stm8_asm\
#STM8_FLASH_DIR	:= E:\VSCode\AsmStudy\STMasm\program\stm8flash\
#INCLUDE_DIR 	:= E:\VSCode\AsmStudy\STMasm\STM8S103\Blink

BUILD_DIR	:= build

STM8S_NAME	:= STM8S103F
STM8S_ASM	:= ../libs/$(STM8S_NAME).asm
STM8S_LSR	:= $(BUILD_DIR)/$(STM8S_NAME).lsr
STM8S_OBJ	:= $(BUILD_DIR)/$(STM8S_NAME).obj

FILE_NAME	:= SPI_SSD1306_128X64
ASM			:= $(FILE_NAME).asm
LSR			:= $(BUILD_DIR)/$(FILE_NAME).lsr
OBJ			:= $(BUILD_DIR)/$(FILE_NAME).obj

COD			:= $(BUILD_DIR)/$(FILE_NAME).cod

HEX			:= $(BUILD_DIR)/$(FILE_NAME)_stm8s.hex
S19			:= $(BUILD_DIR)/$(FILE_NAME)_stm8s.s19


all: clear
	@echo Finish All
	
compile:
#	@if exist $(BUILD_DIR) (rmdir /Q /S $(BUILD_DIR))
	@if not exist $(BUILD_DIR) (mkdir $(BUILD_DIR))
	@asm.exe -sym -li=$(STM8S_LSR) $(STM8S_ASM) -obj=$(STM8S_OBJ)
	@asm.exe -sym -li=$(LSR) $(ASM) -obj=$(OBJ)
	@lyn $(STM8S_OBJ)+$(OBJ), $(COD), ; 		
	@obsend $(COD),f,$(HEX),ix
	@obsend $(COD),f,$(S19),s	
	@E:\VSCode\AsmStudy\STM8asm\program\stm8flash\stm8flash -c stlinkv2 -p stm8s103f3 -w $(HEX)
#	pause
	
clear: compile
	@del *.err
	@del $(BUILD_DIR)\*.obj
	@del $(BUILD_DIR)\*.lsr
	@del $(BUILD_DIR)\*.cod
	@del $(BUILD_DIR)\*.grp
	@del $(BUILD_DIR)\*.map
	@del $(BUILD_DIR)\*.sym

	
#-li=list\$(STM8S_LSR)
#@asm.exe -sym -li=list\$(LSR) $(ASM) -I=$(INCLUDE_DIR)  -obj=obj\$(OBJ)

