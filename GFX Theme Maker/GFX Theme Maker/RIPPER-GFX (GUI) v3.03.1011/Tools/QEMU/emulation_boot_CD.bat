@echo off
color 3b
rem  ╤ЄрЁЄ QEMU т Windows
title Старт QEMU в Windows
IF NOT EXIST "%SystemRoot%\system32\drivers\kqemu.sys" %SystemRoot%\System32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 %~dp0kqemu.inf
echo.
echo.
echo ===============================================================================
echo  QEMU эмулирует загрузку с любого CD-диска
echo  Для загрузки требуется указать букву CD-привода.
echo  При захвате мышки для выхода использовать Ctrl+Alt или клавиша windows
echo  В батнике параметр -m 320 указывает на выделяемую память 320 Мб (ОЗУ).
echo ===============================================================================
echo.
setlocal
set /p disk=Введите букву CD-привода (C-Z) и жмите Enter, вводите:
%~dp0qemu.exe -L . -m 720 -hda "\\.\PhysicalDrive0" -cdrom %disk%: -boot d