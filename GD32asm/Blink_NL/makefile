
TOOL_CHAIN			:= E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin
PREFIX				:= riscv-none-embed-

filname := Blink_NL

srcdir := src
builddir := build
libdir := lib

CROSS_COMPILE=$(TOOL_CHAIN)\$(PREFIX)
CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump
SIZE=$(CROSS_COMPILE)size

COMMON := -march=rv32imac -mabi=ilp32 -mcmodel=medany
ASMFLAGS := $(COMMON)
LDFLAGS := -march=rv32imac -mabi=ilp32 -mcmodel=medany -nostdlib 

frmname = $(builddir)/$(filname)
objs = $(addprefix $(builddir)/,$(addsuffix .o,$(filname)))

all: $(frmname).bin $(frmname).hex size

$(frmname).bin: $(frmname).elf
	$(OBJCOPY) -O binary $^ $@

$(frmname).hex: $(frmname).elf
	$(OBJCOPY) -O ihex $(frmname).elf $(frmname).hex

$(frmname).elf: $(objs) $(LSCRIPT)
	@-mkdir $(builddir)
	@ echo "..linking"
	$(LD) $(LDFLAGS) $(objs) -o $@ 

$(builddir)/%.o: $(srcdir)/%.c
	@-mkdir $(builddir)
	$(CC) -c $(CFLAGS) $< -o $@

$(builddir)/%.o: $(srcdir)/%.S
	@-mkdir $(builddir)
	$(CC) -c $(ASMFLAGS) $< -o $@
	
clean:
	rm -rf $(builddir)

size: $(frmname).elf
	$(SIZE) $(frmname).elf

prog: $(frmname).bin
	stm32flash /dev/ttyUSB0 -w $(frmname).bin

dfu: $(frmname).bin
	dfu-util -a 0 -d 28e9:0189 -s 0x08000000 -D $(frmname).bin

# -include $(shell mkdir -p $(builddir)/dep) $(wildcard $(builddir)/dep/*)

.PHONY: all clean


# "E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin\riscv-none-embed-gcc" -march=rv32imac -mabi=ilp32 -mcmodel=medany -nostdlib src/main.S -o build/main.elf
# "E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin\riscv-none-embed-objcopy" -O binary build/main.elf build/main.bin
# "E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin\riscv-none-embed-objcopy" -O ihex build/main.elf build/main.hex
# E:\Program\dfu-util\dfu-util -a 0 -d 28e9:0189 -s 0x08000000 -D build/main.bin
# stm32flash /dev/ttyUSB0 -w build/main.bin