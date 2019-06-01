#include <natax/kernel.h>
#include <vga.h>

void quarrel(const char * str)
{
	vga_cls();
	vga_puts("\n Kernel quarrel! Error:\n ");
	vga_puts(str);
	while(1);
}
