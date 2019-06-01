#version
VERSION = 0
PATCHLEVEL = 0
SUBLEVEL = 0.1
EXTRAVERSION = 0

#Tools
CC = gcc
CFLAGS = -c -nostdlib -nostartfiles -nodefaultlibs -m32 -fno-builtin -fno-pie \
-Iinclude -fomit-frame-pointer
AS = as
CXX = g++
Q = @
PRINT = echo -e

#files ext .o 
OBJ = init/main.o boot/boot.o kernel/quarrel.o kernel/gdt.o kernel/gdtset.o kernel/vga.o

DEPS = include/*.h

#no file - rule
PHONY = clean

#compile C src files
%.o: %.c  $(DEPS) 
	$(Q)$(PRINT) '\t CC \t $@'
	$(Q)$(CC) $(CFLAGS) $< -o  $@
#assembly (GNU AS)
%.o: %.S
	$(Q)$(PRINT) '\t AS \t $@'
	$(Q)$(AS) -32 -o $@ $<
#assembly (NASM)
%.o: %.asm
	$(Q)$(PRINT) '\t AS \t $@'
	$(Q)nasm -f elf -o $@ $<
all: kernel.bin
#link kernel
kernel.bin: $(OBJ) linker.ld
	$(Q)$(PRINT) '\t LD \t $@'
	$(Q)ld -melf_i386 -T linker.ld -o ./kernel.bin $(OBJ)
clean:
	$(Q)rm -f $(OBJ)
test:
	$(Q)qemu-system-i386 -kernel kernel.bin
.PHONY = $(PHONY)
