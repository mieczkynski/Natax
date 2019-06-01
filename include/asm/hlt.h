#ifndef _HLT_H
#define _HLT_H

void hlt()
{
	asm volatile("hlt");
}

#endif
