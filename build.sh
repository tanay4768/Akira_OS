#!/bin/bash

i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T linker.ld -o akira_os.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
if grub-file --is-x86-multiboot akira_os.bin; then
  echo multiboot confirmed
else
  echo the file is not multiboot
fi
mkdir -p isodir/boot/grub
cp akira_os.bin isodir/boot/akira_os.bin
cp grub.cfg isodir/boot/grub/grub.cfg
grub-mkrescue -o akira_os.iso isodir
qemu-system-i386 -cdrom akira_os.iso