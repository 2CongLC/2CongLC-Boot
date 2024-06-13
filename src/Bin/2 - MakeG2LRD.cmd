@setlocal enableextensions
@echo off
pushd "%cd%"& cd /d "%~dp0"

cd i386-pc
copy /b boot.img+core.img ..\..\Src\BOOT\Grub2\g2ldr
copy boot.img ..\..\Src\BOOT\Grub2\i386-pc\boot.img
copy core.img ..\..\Src\BOOT\Grub2\i386-pc\core.img

cd /d ..
if exist "..\Src\BOOT\Grub2\i386-pc\core.img" call "3.1 - MakeUEFI32.cmd"