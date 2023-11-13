
TOOL_CHAIN			:= E:\Program\MounRiver/MounRiver_Studio/toolchain/RISC-V Embedded GCC/bin
# TOOL_CHAIN = C:/Program Files/Toolchain/xpack-riscv-none-embed-gcc-10.2.0-1.1/bin
PREFIX				:= riscv-none-embed-
OCD_PATH = E:/Program/OpenOCD/bin
# OCD_PATH = C:/Program Files/Toolchain/xpack-openocd-0.10.0-15/bin
OCD = "$(OCD_PATH)/openocd"




filname := Blink_NL

srcdir := src
builddir := build

CROSS_COMPILE=$(TOOL_CHAIN)\$(PREFIX)
CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)gcc
LD=$(CROSS_COMPILE)gcc
OBJCOPY=$(CROSS_COMPILE)objcopy
OBJDUMP=$(CROSS_COMPILE)objdump
SIZE=$(CROSS_COMPILE)size

ASMFLAGS := -march=rv32imac -mabi=ilp32 -mcmodel=medany
LDFLAGS := -march=rv32imac -mabi=ilp32 -mcmodel=medany -nostdlib 

OPENOCD_CFG=../libs/Util/gd32vf103.cfg

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



flash:
	$(OCD) -f $(OPENOCD_CFG) -c init -c halt -c "program $(BUILD_DIR)/$(frmname).hex" -c reset -c resume -c exit

