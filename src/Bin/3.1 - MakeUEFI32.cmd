@setlocal enableextensions
@echo off
pushd "%cd%"& cd /d "%~dp0"

grub-mkimage --prefix /BOOT/Grub2 --output ..\Src\EFI\BOOT\bootia32.efi --format i386-efi --compression auto --config "0 - load.cfg" part_gpt part_msdos ext2 fat ntfs hfsplus search_fs_file

if exist "..\Src\EFI\BOOT\bootia32.efi" call "3.2 - MakeUEFI64.cmd"