
TARGET = Blink

BUILD_DIR = build

GCC_PATH = C:/Program Files/Toolchain/xpack-riscv-none-embed-gcc-10.2.0-1.1/bin
OCD_PATH = C:/Program Files/Toolchain/xpack-openocd-0.10.0-15/bin

OCD = "$(OCD_PATH)/openocd"

PREFIX = riscv-none-embed-

CC = "$(GCC_PATH)/$(PREFIX)gcc"
AS = "$(GCC_PATH)/$(PREFIX)gcc" -x assembler-with-cpp
CP = "$(GCC_PATH)/$(PREFIX)objcopy"
SZ = "$(GCC_PATH)/$(PREFIX)size"

LDSCRIPT = ../libs/Ld/link_Flash.ld

LDFLAGS = -march=rv32imc -mabi=ilp32 -static -mcmodel=medany -fvisibility=hidden -nostdlib -nostartfiles -T$(LDSCRIPT)

HEX = $(CP) -O ihex
BIN = $(CP) -O binary -S 

OPENOCD_CFG=../libs/Util/MLDR187-ft2232hl.cfg

all: flash

build: clean make_folder
	$(CC) $(LDFLAGS) $(TARGET).s -o $(BUILD_DIR)/$(TARGET).elf

	$(HEX) $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex

make_folder:
	@-mkdir $(BUILD_DIR)

clean:
	@-rmdir /s /q $(BUILD_DIR)

erase: build
	$(OCD) -f $(OPENOCD_CFG) -c init -c halt -c "flash erase_sector bank0 0 last" -c exit	

flash: erase 
	$(OCD) -f $(OPENOCD_CFG) -c init -c halt -c "program $(BUILD_DIR)/$(TARGET).hex" -c reset -c exit
	