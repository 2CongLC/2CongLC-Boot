@echo off
color 3b
rem  ����� QEMU � Windows
title ���� QEMU � Windows
IF NOT EXIST "%SystemRoot%\system32\drivers\kqemu.sys" %SystemRoot%\System32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 %~dp0kqemu.inf
echo.
echo.
echo ===============================================================================
echo  QEMU �㫨��� ����㧪� � ��� 䨧��᪮�� ���ன�⢠ (HDD, 䫥誠)
echo  ��� ����㧪� �ॡ���� 㪠���� ����� 䨧��᪮�� ��᪠.
echo  �� ��墠� ��誨 ��� ��室� �ᯮ�짮���� Ctrl+Alt ��� ������ windows
echo  � ��⭨�� ��ࠬ��� -m 320 㪠�뢠�� �� �뤥�塞�� ������ 320 �� (���).
echo ===============================================================================
echo.
echo. 
setlocal
set /p hdd_disk=������ ����� 䨧��᪮�� ��᪠ (0, 1, 2, 3...) � ���� Enter, ������:
qemu.exe -L . -m 320 -hda "\\.\PhysicalDrive%hdd_disk%" -boot c