.global loader				# set visible to linker
.extern main				# main from main.c

	.set FLAGS,	0		# this is the multiboot 'flag' field
	.set MAGIC,	0x1BADB002	# 'magic number' lets bootloader find the header
	.set CHECKSUM,	-(MAGIC + FLAGS)# checksum required
	.set STACKSIZE,	0x4000		# 16 KiB for stack
	.set STACK, 0x0001		# reversed bits of stacksize
	.set SIZESTACK, STACK + STACKSIZE
 
.section .text
.align 4
					# setting multiboot header
multiboot_header:
	.long	MAGIC
   	.long	FLAGS
   	.long	CHECKSUM

loader:

	push	$0
	popf
	mov	$SIZESTACK, %esp	# set up the stack
	push	%eax			# pass multiboot magic number as second parameter
	push	%ebx			# pass multiboot info structure as first parameter
 
	call	main			# call C code
