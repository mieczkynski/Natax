#ifndef _VGA_H
#define _VGA_H

#include <common.h>

void vga_init();

void vga_cls();

void vga_puts(const char* str);

static void vga_scroll();

#endif

