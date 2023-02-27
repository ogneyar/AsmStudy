
ASM_DIR		:= E:\VSCode\AsmStudy\STMasm\program\stm8_asm\
INCLUDE_DIR := E:\VSCode\AsmStudy\STMasm\STM8S003\Blink

BUILD_DIR	:= build

STM8S_NAME	:= STM8S003F
STM8S_ASM	:= $(STM8S_NAME).asm
STM8S_LSR	:= $(STM8S_NAME).lsr
STM8S_OBJ	:= $(STM8S_NAME).obj

FILE_NAME	:= Blink
ASM			:= $(FILE_NAME).asm
LSR			:= $(FILE_NAME).lsr
OBJ			:= $(FILE_NAME).obj

COD			:= $(FILE_NAME).cod

HEX			:= $(FILE_NAME)_stm8s003.hex
S19			:= $(FILE_NAME)_stm8s003.s19

all: compile
	@echo Finish All
	
compile:
	@E:\VSCode\AsmStudy\STMasm\program\stm8_asm\asm.exe -sym -li=$(BUILD_DIR)\$(STM8S_LSR) $(STM8S_ASM) -obj=$(BUILD_DIR)\$(STM8S_OBJ)
	@E:\VSCode\AsmStudy\STMasm\program\stm8_asm\asm.exe -sym -li=$(BUILD_DIR)\$(LSR) $(ASM) -obj=$(BUILD_DIR)\$(OBJ)
	@E:\VSCode\AsmStudy\STMasm\program\stm8_asm\lyn $(BUILD_DIR)\$(STM8S_OBJ)+$(BUILD_DIR)\$(OBJ), $(BUILD_DIR)\$(COD), ; 	
	@E:\VSCode\AsmStudy\STMasm\program\stm8_asm\obsend $(BUILD_DIR)\$(COD),f,$(BUILD_DIR)\$(HEX),ix
	@E:\VSCode\AsmStudy\STMasm\program\stm8_asm\obsend $(BUILD_DIR)\$(COD),f,$(BUILD_DIR)\$(S19),s	
	@E:\VSCode\AsmStudy\STMasm\program\stm8flash\stm8flash -c stlinkv2 -p stm8s003f3 -w $(BUILD_DIR)\$(HEX)
	pause

#-li=list\$(STM8S_LSR)
#@asm.exe -sym -li=list\$(LSR) $(ASM) -I=$(INCLUDE_DIR)  -obj=obj\$(OBJ)

