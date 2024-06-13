@setlocal enableextensions
@echo off
pushd "%cd%"& cd /d "%~dp0"

grub-mkimage --prefix /BOOT/Grub2 --output ..\Src\EFI\BOOT\bootx64.efi --format x86_64-efi --compression auto --config "0 - load.cfg" part_gpt part_msdos ext2 fat ntfs hfsplus search_fs_file

Echo Done !
Pause>nul