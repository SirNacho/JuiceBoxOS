#!/bin/bash
#This bash script is created by Sir Nacho in 7/16/2025

rm -rf -v *.o *.iso *.bin isodir 
i686-elf-as boot.s -o boot.o 
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T linker.ld -o juiceboxos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc 
grub-file --is-x86-multiboot juiceboxos.bin 
mkdir -p isodir/boot/grub && cp juiceboxos.bin isodir/boot/juiceboxos.bin 
cp grub.cfg isodir/boot/grub/grub.cfg 
grub-mkrescue -o juiceboxos.iso isodir 
qemu-system-i386 -cdrom juiceboxos.iso
