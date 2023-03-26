

# 	НЕ РАБОТАЕТ!!!


T=$(shell cygpath -u $(LOCALAPPDATA))
MODULE_PATH?=$(T)/Arduino15/packages/arduino
RM=rm
SEP=/
ARM_GCC_PATH?=$(MODULE_PATH)/tools/arm-none-eabi-gcc/7-2017q4/bin/arm-none-eabi-
BUILD_PATH=build

# -----------------------------------------------------------------------------
# Tools
CC=$(ARM_GCC_PATH)gcc
OBJCOPY=$(ARM_GCC_PATH)objcopy
NM=$(ARM_GCC_PATH)nm
SIZE=$(ARM_GCC_PATH)size

# -----------------------------------------------------------------------------
# Boards definitions
BOARD_ID?=arduino_zero
NAME?=samd21_sam_ba


# -----------------------------------------------------------------------------
# Compiler options
SAM_BA_INTERFACES?=SAM_BA_BOTH_INTERFACES
CFLAGS_EXTRA=-D__SAMD21G18A__ -DBOARD_ID_$(BOARD_ID) -D$(SAM_BA_INTERFACES)
CFLAGS=-mthumb -mcpu=cortex-m0plus -Wall -c -std=gnu99 -ffunction-sections -fdata-sections -nostdlib -nostartfiles --param max-inline-insns-single=500
ifdef DEBUG
  CFLAGS+=-g3 -O1 -DDEBUG=1
else
  CFLAGS+=-Os -DDEBUG=0 -flto
endif

ifdef SECURE_BY_DEFAULT
  CFLAGS+=-DSECURE_BY_DEFAULT=1
endif

ELF=$(NAME).elf
BIN=$(NAME).bin
HEX=$(NAME).hex

INCLUDES=-I"$(MODULE_PATH)/tools/CMSIS/4.5.0/CMSIS/Include/" -I"$(MODULE_PATH)/tools/CMSIS-Atmel/1.2.0/CMSIS/Device/ATMEL/"


# -----------------------------------------------------------------------------
# Linker options
LDFLAGS=-mthumb -mcpu=cortex-m0plus -Wall -Wl,--cref -Wl,--check-sections -Wl,--gc-sections -Wl,--unresolved-symbols=report-all
LDFLAGS+=-Wl,--warn-common -Wl,--warn-section-align -Wl,--warn-unresolved-symbols --specs=nano.specs --specs=nosys.specs


# -----------------------------------------------------------------------------
# Source files and objects
SOURCES= \








TOOL_CHAIN			:= E:\Program\BOSSA
OPENOCD_SCRIPTS		:= E:\Program\OpenOCD\share\openocd\scripts
OPENOCD_INTERFACE	:= interface\stlink.cfg
OPENOCD_TARGET		:= ../libs/arduino_zero.cfg

PORT		:= com22

BUILD_DIR	:= build

STM_MAP_LD		:= ../libs/samd21_map.ld

FILE_NAME	:= main
ASM			:= $(FILE_NAME).asm
OBJ			:= $(BUILD_DIR)/$(FILE_NAME).o
ELF			:= $(BUILD_DIR)/$(FILE_NAME).elf
HEX			:= $(BUILD_DIR)/$(FILE_NAME)_samd21.hex
BIN			:= $(BUILD_DIR)/$(FILE_NAME)_samd21.bin


# E:\Program\BOSSA\bossac -e -w -v -R -pcom2 Blink.bin
# E:\Program\BOSSA\bossac -pcom2 -r0x10000 image.bin

# C:\Users\ogney\AppData\Local\Arduino15\packages\arduino\tools\bossac\1.7.0-arduino3\bossac -pcom2 -r0x10000 image.bin
