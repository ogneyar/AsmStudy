
TARGET = main

BUILD_DIR = build

GCC_PATH = E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin
OCD_PATH = E:/Program/OpenOCD/bin

OCD = "$(OCD_PATH)/openocd"

PREFIX = riscv-none-embed-

CC = "$(GCC_PATH)/$(PREFIX)gcc"
AS = "$(GCC_PATH)/$(PREFIX)gcc" -x assembler-with-cpp
CP = "$(GCC_PATH)/$(PREFIX)objcopy"
DP = "$(GCC_PATH)/$(PREFIX)objdump"
SZ = "$(GCC_PATH)/$(PREFIX)size"

LDSCRIPT = ../libs/Ld/ch32v20x_map.ld

LDFLAGS = -march=rv32ecxw -mabi=ilp32e -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -T$(LDSCRIPT)

HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S 

OPENOCD_CFG=../libs/Util/wch-riscv.cfg

all: flash

build: clean make_folder
	$(CC) $(LDFLAGS) $(TARGET).s -o $(BUILD_DIR)/$(TARGET).elf

	$(HEX) $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/firmware.hex
	$(BIN) $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/firmware.bin

	$(DP) -S -D $(BUILD_DIR)/$(TARGET).elf > $(BUILD_DIR)/$(TARGET).lss

	$(SZ) $(BUILD_DIR)/$(TARGET).elf

make_folder:
	@-mkdir $(BUILD_DIR)

clean:
	@-rmdir /s /q $(BUILD_DIR)

erase: build
	$(OCD) -f $(OPENOCD_CFG) -c init -c halt -c "flash erase_sector wch_riscv 0 last" -c exit

flash: erase 
	$(OCD) -f $(OPENOCD_CFG) -c init -c halt -c "program $(BUILD_DIR)/firmware.hex" -c wlink_reset_resume -c exit

reset:
	$(OCD) -f $(OPENOCD_CFG) -c init -c wlink_reset_resume -c exit
