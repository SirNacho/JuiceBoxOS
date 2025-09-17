/* This script is created by Sir Nacho 
 *
 * CREDIT: https://wiki.osdev.org/Bare_Bones
 *
 * */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
//#include <time.h>

//This is to make sure that I used the built cross-compiler and not the standard compiler 
//on the developer's host.
#if defined(__linux__)
#error "You are not using a cross-compiler, you will most certainly run into trouble"
#endif

#if !defined(__i386__)
#error "This tutorial needs to be compiled with a ix86-elf compiler"
#endif

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

static inline uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg) 
{
	return fg | bg << 4;
}

static inline uint16_t vga_entry(unsigned char uc, uint8_t color) 
{
	return (uint16_t) uc | (uint16_t) color << 8;
}

size_t strlen(const char* str) 
{
	size_t len = 0;
	while (str[len])
		len++;
	return len;
}

//Default values for terminal size
#define VGA_WIDTH   80
#define VGA_HEIGHT  25
#define VGA_MEMORY  0xB8000 

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;
uint16_t* terminal_buffer = (uint16_t*)VGA_MEMORY;

void term_initialize(void) 
{
	terminal_row = 0;
	terminal_column = 0;
	terminal_color = vga_entry_color(VGA_COLOR_MAGENTA, VGA_COLOR_BLACK); //<---- This should be easier to change colors...
	
	for (size_t y = 0; y < VGA_HEIGHT; y++) {
		for (size_t x = 0; x < VGA_WIDTH; x++) {
			const size_t index = y * VGA_WIDTH + x;
			terminal_buffer[index] = vga_entry(' ', terminal_color);
		}
	}
}

//This section is dedicated to printing characters on the terminal.
void term_setcolor(uint8_t color) 
{
	terminal_color = color;
}

void term_putentryat(char c, uint8_t color, size_t x, size_t y) 
{
	const size_t index = y * VGA_WIDTH + x;
	terminal_buffer[index] = vga_entry(c, color);
}

void term_putchar(char c) 
{
	term_putentryat(c, terminal_color, terminal_column, terminal_row);

  if (c == '\n') {
    terminal_column = 0;
    terminal_row += 1;
  }

	if (++terminal_column == VGA_WIDTH) {
		terminal_column = 0;
		if (++terminal_row == VGA_HEIGHT)
			terminal_row = 0;
	}
}

void term_write(const char* data, size_t size) 
{
	for (size_t i = 0; i < size; i++)
		term_putchar(data[i]);
}

void term_writestring(const char* data) 
{
	term_write(data, strlen(data));
}

//Testing functions section
//void term_wait(size_t secs) {
  //size_t int waitTime = time(0) + secs;
  //while (time(0) < waitTime);
//}

void kernel_main(void) 
{
	term_initialize();
	term_writestring("Hi, this is Steven Frausto from DePaul University, I finally made a 32bit kernel! :) \n Is this a new line?");

  //Testing for terminal scrolling
  //for (size_t i = 0; i < (terminal_column * terminal_row) * 2; i ++)
    
    //term_wait(5);

    //term_writestring("Testing!!! ");
}
