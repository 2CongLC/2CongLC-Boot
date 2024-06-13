@setlocal enableextensions
@echo off
pushd "%cd%"& cd /d "%~dp0"

grub-mkimage --prefix /BOOT/Grub2 --output i386-pc/core.img --format i386-pc --compression auto --config "0 - load.cfg" biosdisk part_msdos ext2 fat ntfs search_fs_file

if exist "i386-pc/core.img" call "2 - MakeG2LRD.cmd"

