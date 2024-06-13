@echo off
color 3b
rem  ╤ЄрЁЄ QEMU т Windows
title Старт QEMU в Windows
IF NOT EXIST "%SystemRoot%\system32\drivers\kqemu.sys" %SystemRoot%\System32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 %~dp0kqemu.inf
echo.
echo.
echo ===============================================================================
echo  QEMU эмулирует загрузку с любого физического устройства (HDD, флешка)
echo  Для загрузки требуется указать номер физического диска.
echo  При захвате мышки для выхода использовать Ctrl+Alt или клавиша windows
echo  В батнике параметр -m 320 указывает на выделяемую память 320 Мб (ОЗУ).
echo ===============================================================================
echo.
echo. 
setlocal
set /p hdd_disk=Введите номер физического диска (0, 1, 2, 3...) и жмите Enter, вводите:
qemu.exe -L . -m 320 -hda "\\.\PhysicalDrive%hdd_disk%" -boot c