#include <common.h>
#include <gdt.h>
#include <asm/hlt.h>
#include <asm/io.h>
#include <vga.h>
#include <natax/kernel.h>
#include <time.h>

#define CMOS_READ(addr) ({ \
outb_p(0x80|addr,0x70); \
inb_p(0x71); \
})

#define BCD_TO_BIN(val) ((val)=((val)&15) + ((val)>>4)*10)
static void time_init(void)
{
	struct tm time;

	do {
		time.tm_sec = CMOS_READ(0);
		time.tm_min = CMOS_READ(2);
		time.tm_hour = CMOS_READ(4);
		time.tm_mday = CMOS_READ(7);
		time.tm_mon = CMOS_READ(8)-1;
		time.tm_year = CMOS_READ(9);
	} while (time.tm_sec != CMOS_READ(0));
	BCD_TO_BIN(time.tm_sec);
	BCD_TO_BIN(time.tm_min);
	BCD_TO_BIN(time.tm_hour);
	BCD_TO_BIN(time.tm_mday);
	BCD_TO_BIN(time.tm_mon);
	BCD_TO_BIN(time.tm_year);
	//startup_time = kernel_mktime(&time);
}
int main(void* mbd, unsigned int magic)
{
	/** Init GDT **/
	gdt_init();
	/** init vga **/
	vga_init();
	/** init time **/
	time_init();



	/** clear vga**/
	vga_cls();

	if (magic != 0x2BADB002)
	{
		quarrel("Error");
	}

	vga_puts("Hello from kernel!");
	//u32int * address = 0x0012F;
	//*address = 0xFFFFF;
	quarrel("No error");
	while (1)
		hlt();

	return 0;
}
