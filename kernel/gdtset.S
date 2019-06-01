.global gdt_set

gdt_set:
	mov	4(%esp), %eax	/** get passed pointer **/
	lgdt	(%eax)        	/** load new GDT pointer **/

	mov	$0x10, %ax	/** load all data segment registers **/
	mov	%ax, %ds
	mov	%ax, %es
	mov	%ax, %fs
	mov	%ax, %gs
	mov	%ax, %ss
	jmp	$0x08,$flush2	/** far jump to code segment **/
flush2:
	ret


