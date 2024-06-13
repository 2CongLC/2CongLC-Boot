#NoTrayIcon
Global $fokys0, $fokys1, $fokys2, $fokys3

If not FileExists(@WindowsDir&'\system32\drivers\kqemu.sys') Then
	$answer = MsgBox(4, "�������� �����������", '���������� ������� kqemu.sys?')
	If $answer = "6" Then RunWait ( @Comspec & ' /C '&@WindowsDir&'\system32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 '&@ScriptDir&'\kqemu.inf', '', @SW_HIDE )
Else
EndIf 


Global $aRecords, $y, $list
Global $Ini = @ScriptDir&'\gui_qemu.ini' ; ���� � gui_qemu.ini
;�������� ������������� gui_qemu.ini
$answer = ""
If Not FileExists($Ini) Then $answer = MsgBox(4, "�������� �����������", "������ ������� ����������� gui_qemu.ini ��� ���������� �������� ����������?")
If $answer = "6" Then
	IniWriteSection($Ini, "ram", 'ram1=256'&@LF&'ram2=512'&@LF&'ram3=768'&@LF&'ram4=128')
	IniWriteSection($Ini, "iso", '')
	IniWriteSection($Ini, "Drive", 'PhysicalDrive0=0'&@LF&'PhysicalDrive1=0'&@LF&'PhysicalDrive2=0'&@LF&'PhysicalDrive3=0')
	IniWriteSection($Ini, "face", 'vkladka00=1')
	IniWriteSection($Ini, "cd", 'cd=E')
EndIf
;��������� gui_qemu.ini
$ram1= IniRead ($Ini, "ram", "ram1", "256")
$ram2= IniRead ($Ini, "ram", "ram2", "512")
$ram3= IniRead ($Ini, "ram", "ram3", "768")
$ram4= IniRead ($Ini, "ram", "ram4", "128")

$Drive0 = IniRead ($Ini, "Drive", "PhysicalDrive0", "0")
$Drive1 = IniRead ($Ini, "Drive", "PhysicalDrive1", "0")
$Drive2 = IniRead ($Ini, "Drive", "PhysicalDrive2", "0")
$Drive3 = IniRead ($Ini, "Drive", "PhysicalDrive3", "0")

$cddvd = IniRead ($Ini, "cd", "cd", "E")

$vkladka00 = IniRead ($Ini, "face", "vkladka00", "1")

GUICreate("�������� �� qemu",500,320, -1, -1, -1, 0x00000010) ; ������ ����
GUISetFont(9, 300)
$tab=GUICtrlCreateTab (0,2, 500,318) ; ������ �������
GUICtrlCreateLabel ("����������� drag-and-drop", 240,5,170,16)
$qemuini=GUICtrlCreateButton ("gui_qemu.ini", 400,2,88,20)
; ��������� ������ �� ������
Switch $vkladka00
Case $vkladka00=0
    $fokys0 = 0x0001
Case $vkladka00=1
    $fokys1 = 0x0001
Case $vkladka00=2
    $fokys2 = 0x0001
Case $vkladka00=3
    $fokys3 = 0x0001
EndSwitch

; HDD
;=============================================================
$tab0=GUICtrlCreateTabitem ("HDD") 
GUICtrlCreateLabel ("������������ � gui_qemu.ini.", 30,280,350,20)

$Label00=GUICtrlCreateLabel ("�������� ������, ��", 20,60,160,20)
GUICtrlSetTip(-1, "�������� ������ ������������ ����������")
$tab0combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram1&'|256|512|768|1024', $ram1)


$Label01=GUICtrlCreateLabel ("���������� ���� (������)", 20,90,160,20)
GUICtrlSetTip(-1, "������� ����������� HDD, ������ � ����")
$tab0combo1=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive0&'|0|1|2', $Drive0)
$vkladka0=GUICtrlCreateButton ("�����", 390,280,87,22, $fokys0)

; CD,DVD
;=============================================================
$tab1=GUICtrlCreateTabitem ( "CD,DVD")
GUICtrlCreateLabel ("������������ � gui_qemu.ini.", 30,280,350,20)

$Label10=GUICtrlCreateLabel ("�������� ������, ��", 20,60,160,20)
GUICtrlSetTip(-1, "�������� ������ ������������ ����������")
$tab1combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram2&'|256|512|768|1024', $ram2)

$Label11=GUICtrlCreateLabel ("���������� ���� (������)", 20,90,160,20)
GUICtrlSetTip(-1, "������� ��������� HDD, ������ � ����")
$tab1combo1=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive1&'|0|1|2', $Drive1)

$checkCN013=GUICtrlCreateCheckbox ("��������� ����", 255,90,170,20)
GuiCtrlSetState(-1, 1)

$Label12=GUICtrlCreateLabel ("����� CD,DVD-�����", 20,120,160,20)
$tab1combo2=GUICtrlCreateCombo ("", 180,120,65,18)
GUICtrlSetData(-1,$cddvd&'|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', $cddvd)
$vkladka1=GUICtrlCreateButton ("�����", 390,280,87,22, $fokys1)


; ISO
;=============================================================
$tab2=GUICtrlCreateTabitem ("ISO")
GUICtrlCreateLabel ("������������ � gui_qemu.ini.", 30,280,350,20)

$Label20=GUICtrlCreateLabel ("�������� ������, ��", 20,60,160,20)
GUICtrlSetTip(-1, "�������� ������ ������������ ����������")
$tab2combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram3&'|256|512|768|1024', $ram3)

$Label21=GUICtrlCreateLabel ("������� ISO-����", 20,130,200,20)
GUICtrlSetTip(-1, "������� � ������ (gui_qemu.ini)")
$tab2combo1=GUICtrlCreateCombo ("", 20,150,460,18)
_listcombo()

GUICtrlCreateGroup("", 16, 175, 468, 77)
$tab2input=GUICtrlCreateInput ("", 20,190,420,22)
GUICtrlSetState(-1,8)
$isofile=GUICtrlCreateButton ("...", 445,189,35,24)
$save1=GUICtrlCreateButton ("^ ��������� � ������ ^", 173,220,140,24)
GUICtrlSetTip(-1, "���������� ���� � ini-����"&@CRLF&"� �������� � ���������")

$Label23=GUICtrlCreateLabel ("���������� ���� (������)", 20,90,160,20)
GUICtrlSetTip(-1, "������� ��������� HDD, ������ � ����")
$tab2combo3=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive2&'|0|1|2', $Drive2)

$checkCN023=GUICtrlCreateCheckbox ("��������� ����", 255,90,170,20)
GuiCtrlSetState(-1, 1)
GUICtrlSetTip($checkCN023, "��������� iso ������� ����, ������ �������� � ������, ����������������� � ����������")

$vkladka2=GUICtrlCreateButton ("�����", 390,280,87,22, $fokys2)



; IMA
;=============================================================
$tab3=GUICtrlCreateTabitem ("IMA")
GUICtrlCreateLabel ("������������ � gui_qemu.ini.", 30,280,350,20)

GUICtrlCreateLabel ("�������� ������, ��", 20,60,160,20)
GUICtrlSetTip(-1, "�������� ������ ������������ ����������")
$tab3combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram4&'|256|512|768|1024', $ram4)

GUICtrlCreateLabel ("���������� ���� (������)", 20,90,160,20)
GUICtrlSetTip(-1, "������� ��������� HDD, ������ � ����")
$tab3combo1=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive3&'|0|1|2', $Drive3)

$tab3input=GUICtrlCreateInput ("", 40,150,400,22)
GUICtrlSetState(-1,8)
$imafile=GUICtrlCreateButton ("...", 445,149,35,24)

$checkCN033=GUICtrlCreateCheckbox ("��������� ����", 255,90,170,20)
GuiCtrlSetState(-1, 1)
GUICtrlSetTip($checkCN033, "����������������� � ����������")

$vkladka3=GUICtrlCreateButton ("�����", 390,280,87,22, $fokys3)

; ?
;=============================================================
$tab4=GUICtrlCreateTabitem ("?")
GUICtrlCreateLabel ("����� ��� ��������� ����������� � gui_qemu.ini.", 20,40,380,20)
GUICtrlCreateLabel ("������� kqemu.sys ��������� ��� ������ QEMU.", 20,60,450,20)
GUICtrlCreateLabel ("��� ��������, ���� ������ �������������� ������ ����.", 20,80,450,20)
GUICtrlCreateLabel ("Ctrl+Alt ��� Windows - ���������� ������.", 20,100,450,20)
GUICtrlCreateLabel ("���� ��������� �������� � ������, �� ������ ��� ������, �� ����� ������", 20,120,450,20)
GUICtrlCreateLabel ("���������, ����������� - �������� �����.", 20,140,450,20)
GUICtrlCreateLabel ("AZJIO 17.02.2010", 360,270,100,32)

$zzz=GUICtrlCreateButton ("����������", 390+111,40,87,22) ; ������� �������� ������
GUICtrlSetTip(-1, "���������� ���������� �� ��������")

				  ;MsgBox(0, "Readme", $tab3)
				  ;3 6 13 23 39 49

; ��������� ������ ������������ �� �������� �������
;GUICtrlSetState(Eval('vkladka' & $vkladka00),16)


GUICtrlSetState(Eval('tab' & $vkladka00),16)

GUICtrlCreateTabitem ("")   ; ����� �������

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $zzz
					$ram00=GUICtrlRead ($tab0combo0)
					$drv00=GUICtrlRead ($tab0combo1)
					$ram10=GUICtrlRead ($tab1combo0)
					$drv10=GUICtrlRead ($tab1combo1)
					$ram20=GUICtrlRead ($tab2combo0)
					$iso20=GUICtrlRead ($tab2combo1)
					MsgBox(0, "����������", '������ �� ������� HDD='&$ram00&' ��'&@CRLF&'����� ����������� ����� �� ������� HDD='&$drv00&@CRLF&'������ �� ������� CD,DVD='&$ram10&' ��'&@CRLF&'����� ����������� ����� �� ������� CD,DVD='&$drv10&@CRLF&'������ �� ������� ISO='&$ram20&' ��'&@CRLF&'����='&$iso20)
					
			Case $msg = $vkladka0
					$ram00=GUICtrlRead ($tab0combo0)
					$drv00=GUICtrlRead ($tab0combo1)
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\qemu.exe -L . -m '&$ram00&' -hda ""\\.\PhysicalDrive'&$drv00&'"" -boot c', '', @SW_HIDE )
					IniWrite(@ScriptDir&'\gui_qemu.ini', "ram", "ram1", $ram00)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "Drive", "PhysicalDrive0", $drv00)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "face", "vkladka00", "0")
            Case $msg = $vkladka1
					$ram10=GUICtrlRead ($tab1combo0)
					$drv10=GUICtrlRead ($tab1combo1)
					$cdd10=GUICtrlRead ($tab1combo2)
					If GUICtrlRead ($checkCN013)=1 Then
						RunWait ( @Comspec & ' /C qemu.exe -L . -m '&$ram10&' -hda ""\\.\PhysicalDrive'&$drv10&'"" -cdrom '&$cdd10&': -boot d', '', @SW_HIDE )
					Else
						RunWait ( @Comspec & ' /C qemu.exe -L . -m '&$ram10&' -cdrom '&$cdd10&': -boot d', '', @SW_HIDE )
					EndIf
					IniWrite(@ScriptDir&'\gui_qemu.ini', "ram", "ram2", $ram10)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "Drive", "PhysicalDrive1", $drv10)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "cd", "cd", $cdd10)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "face", "vkladka00", "1")
            Case $msg = $vkladka2
					$ram20=GUICtrlRead ($tab2combo0)
					$drv20=GUICtrlRead ($tab2combo3)
					$iso20=GUICtrlRead ($tab2combo1)
					If not FileExists($iso20) Then
					$Box20=MsgBox(0, "������", "�������� ������������ iso-����.")
					ContinueLoop
					EndIf
					If GUICtrlRead ($checkCN023)=1 Then
						RunWait ( @Comspec & ' /C qemu.exe -L . -m '&$ram20&' -hda ""\\.\PhysicalDrive'&$drv20&'"" -cdrom "'&$iso20&'" -boot d', '', @SW_HIDE )
					Else
						RunWait ( @Comspec & ' /C qemu.exe -L . -m '&$ram20&' -cdrom "'&$iso20&'" -boot d', '', @SW_HIDE )
					EndIf
					IniWrite(@ScriptDir&'\gui_qemu.ini', "ram", "ram3", $ram20)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "Drive", "PhysicalDrive2", $drv20)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "face", "vkladka00", "2")
            Case $msg = $vkladka3
					$ram30=GUICtrlRead ($tab3combo0)
					$drv30=GUICtrlRead ($tab3combo1)
					$ima30=GUICtrlRead ($tab3input)
					If $ima30 = "" Then MsgBox(0, "������", "�������� ima-����.")
					If GUICtrlRead ($checkCN033)=1 Then
						RunWait ( @Comspec & ' /C qemu.exe -L . -m '&$ram30&' -hda ""\\.\PhysicalDrive'&$drv30&'"" -fda "'&$ima30&'" -boot a', '', @SW_HIDE )
					Else
						RunWait ( @Comspec & ' /C qemu.exe -L . -m '&$ram30&' -fda "'&$ima30&'" -boot a', '', @SW_HIDE )
					EndIf
					IniWrite(@ScriptDir&'\gui_qemu.ini', "ram", "ram4", $ram30)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "Drive", "PhysicalDrive3", $drv30)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "face", "vkladka00", "3")
            Case $msg = $isofile
					GUICtrlSetState($tab2combo1, 128)
					GUICtrlSetState($tab2input, 64)
					$TmpISOFile = FileOpenDialog("����� iso-�����.", @WorkingDir & "", "����� ����� (*.iso)", 1 + 4 )
					GUICtrlSetData($tab2input, $TmpISOFile)
            Case $msg = $save1
					$Path=GUICtrlRead ($tab2input)
					IniWrite(@ScriptDir&'\gui_qemu.ini', "iso", $Path&' ;', '')
					_listcombo()
            Case $msg = $checkCN013
					If GUICtrlRead ($checkCN013)=1 Then
						GUICtrlSetState($tab1combo1, 64)
					Else
						GUICtrlSetState($tab1combo1, 128)
					EndIf
            Case $msg = $checkCN023
					If GUICtrlRead ($checkCN023)=1 Then
						GUICtrlSetState($tab2combo3, 64)
					Else
						GUICtrlSetState($tab2combo3, 128)
					EndIf
            Case $msg = $checkCN033
					If GUICtrlRead ($checkCN033)=1 Then
						GUICtrlSetState($tab3combo1, 64)
					Else
						GUICtrlSetState($tab3combo1, 128)
					EndIf
            Case $msg = $imafile
					$TmpIMAFile = FileOpenDialog("����� ima-�����.", @WorkingDir & "", "����� ������� (*.ima;*.img)", 1 + 4 )
					GUICtrlSetData($tab3input, $TmpIMAFile)
			Case $msg = $qemuini
				ShellExecute(@ScriptDir&'\gui_qemu.ini', "", @ScriptDir, "")
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd
	
	
; ������� �������� ������ ����������
;=============================================================
Func _listcombo()
$ini1 = FileOpen($Ini, 0) ; ����������� � ������ ����
$ini2 = FileRead($ini1)
FileClose($ini1)
$ini2 = StringReplace($ini2, " ;=", "")
$aISO = StringRegExp($ini2, '(?s)\[iso\]([^\[]*)', 3) ; ���������� ��������� ��� ������������ ����������� ������ [iso] � ������
$aRecords = StringSplit($aISO[0], @CRLF)
$x=0
$list=''
;���������� ������ ��� ���������� � �������� �������
For $i=$aRecords[0] To 1 Step -1
If StringMid($aRecords[$i], 2, 2) = ":\" Then
If $x=1 Then
$list&= '|'&$aRecords[$i]
Else
$list&= $aRecords[$i]
$x=1
$y=$aRecords[$i]
EndIf
EndIf
Next
GUICtrlSendMsg($tab2combo1, 0x14B, 0, 0)
GUICtrlSetData($tab2combo1,$list, $y)
EndFunc
