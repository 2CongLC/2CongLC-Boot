@echo off
color 3b
rem  ����� QEMU � Windows
title ���� QEMU � Windows
IF NOT EXIST "%SystemRoot%\system32\drivers\kqemu.sys" %SystemRoot%\System32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 %~dp0kqemu.inf
echo.
echo.
echo ===============================================================================
echo  QEMU �㫨��� ����㧪� � ��� CD-��᪠
echo  ��� ����㧪� �ॡ���� 㪠���� �㪢� CD-�ਢ���.
echo  �� ��墠� ��誨 ��� ��室� �ᯮ�짮���� Ctrl+Alt ��� ������ windows
echo  � ��⭨�� ��ࠬ��� -m 320 㪠�뢠�� �� �뤥�塞�� ������ 320 �� (���).
echo ===============================================================================
echo.
setlocal
set /p disk=������ �㪢� CD-�ਢ��� (C-Z) � ���� Enter, ������:
%~dp0qemu.exe -L . -m 720 -hda "\\.\PhysicalDrive0" -cdrom %disk%: -boot d