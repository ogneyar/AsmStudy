
#ASM_DIR		:= E:\VSCode\AsmStudy\STMasm\program\stm8_asm\
#STM8_FLASH_DIR	:= E:\VSCode\AsmStudy\STMasm\program\stm8flash\
#INCLUDE_DIR 	:= E:\VSCode\AsmStudy\STMasm\STM8S103\Blink

BUILD_DIR	:= build

STM8S_NAME	:= STM8S103F
STM8S_ASM	:= ../libs/$(STM8S_NAME).asm
STM8S_LSR	:= $(STM8S_NAME).lsr
STM8S_OBJ	:= $(STM8S_NAME).obj

FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
LSR			:= $(FILE_NAME).lsr
OBJ			:= $(FILE_NAME).obj

COD			:= $(FILE_NAME).cod

HEX			:= $(FILE_NAME)_stm8s.hex
S19			:= $(FILE_NAME)_stm8s.s19

all: clear
	@echo Finish All
	
compile:
#	@if exist $(BUILD_DIR) (rmdir /Q /S $(BUILD_DIR))
	@if not exist $(BUILD_DIR) (mkdir $(BUILD_DIR))
	@asm.exe -sym -li=$(BUILD_DIR)\$(STM8S_LSR) $(STM8S_ASM) -obj=$(BUILD_DIR)\$(STM8S_OBJ)
	@asm.exe -sym -li=$(BUILD_DIR)\$(LSR) $(ASM) -obj=$(BUILD_DIR)\$(OBJ)
	@lyn $(BUILD_DIR)\$(STM8S_OBJ)+$(BUILD_DIR)\$(OBJ), $(BUILD_DIR)\$(COD), ; 	
	@obsend $(BUILD_DIR)\$(COD),f,$(BUILD_DIR)\$(HEX),ix
	@obsend $(BUILD_DIR)\$(COD),f,$(BUILD_DIR)\$(S19),s	
	@stm8flash -c stlinkv2 -p stm8s103f3 -w $(BUILD_DIR)\$(HEX)
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

