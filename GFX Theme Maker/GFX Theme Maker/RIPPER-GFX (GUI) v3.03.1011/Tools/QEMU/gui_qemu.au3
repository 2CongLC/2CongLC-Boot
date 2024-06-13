#NoTrayIcon
Global $fokys0, $fokys1, $fokys2, $fokys3

If not FileExists(@WindowsDir&'\system32\drivers\kqemu.sys') Then
	$answer = MsgBox(4, "Выгодное предложение", 'Установить драйвер kqemu.sys?')
	If $answer = "6" Then RunWait ( @Comspec & ' /C '&@WindowsDir&'\system32\rundll32.exe setupapi,InstallHinfSection DefaultInstall 132 '&@ScriptDir&'\kqemu.inf', '', @SW_HIDE )
Else
EndIf 


Global $aRecords, $y, $list
Global $Ini = @ScriptDir&'\gui_qemu.ini' ; путь к gui_qemu.ini
;Проверка существования gui_qemu.ini
$answer = ""
If Not FileExists($Ini) Then $answer = MsgBox(4, "Выгодное предложение", "Хотите создать необходимый gui_qemu.ini для сохранения вводимых параметров?")
If $answer = "6" Then
	IniWriteSection($Ini, "ram", 'ram1=256'&@LF&'ram2=512'&@LF&'ram3=768'&@LF&'ram4=128')
	IniWriteSection($Ini, "iso", '')
	IniWriteSection($Ini, "Drive", 'PhysicalDrive0=0'&@LF&'PhysicalDrive1=0'&@LF&'PhysicalDrive2=0'&@LF&'PhysicalDrive3=0')
	IniWriteSection($Ini, "face", 'vkladka00=1')
	IniWriteSection($Ini, "cd", 'cd=E')
EndIf
;считываем gui_qemu.ini
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

GUICreate("Эмуляция на qemu",500,320, -1, -1, -1, 0x00000010) ; размер окна
GUISetFont(9, 300)
$tab=GUICtrlCreateTab (0,2, 500,318) ; размер вкладки
GUICtrlCreateLabel ("используйте drag-and-drop", 240,5,170,16)
$qemuini=GUICtrlCreateButton ("gui_qemu.ini", 400,2,88,20)
; установка фокуса на кнопке
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
GUICtrlCreateLabel ("Конфигурация в gui_qemu.ini.", 30,280,350,20)

$Label00=GUICtrlCreateLabel ("Выделить память, Мб", 20,60,160,20)
GUICtrlSetTip(-1, "Выделить память виртуальному компьютеру")
$tab0combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram1&'|256|512|768|1024', $ram1)


$Label01=GUICtrlCreateLabel ("Физический хард (флешка)", 20,90,160,20)
GUICtrlSetTip(-1, "Выбрать загрузочный HDD, отсчёт с нуля")
$tab0combo1=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive0&'|0|1|2', $Drive0)
$vkladka0=GUICtrlCreateButton ("Старт", 390,280,87,22, $fokys0)

; CD,DVD
;=============================================================
$tab1=GUICtrlCreateTabitem ( "CD,DVD")
GUICtrlCreateLabel ("Конфигурация в gui_qemu.ini.", 30,280,350,20)

$Label10=GUICtrlCreateLabel ("Выделить память, Мб", 20,60,160,20)
GUICtrlSetTip(-1, "Выделить память виртуальному компьютеру")
$tab1combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram2&'|256|512|768|1024', $ram2)

$Label11=GUICtrlCreateLabel ("Физический хард (флешка)", 20,90,160,20)
GUICtrlSetTip(-1, "Выбрать доступный HDD, отсчёт с нуля")
$tab1combo1=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive1&'|0|1|2', $Drive1)

$checkCN013=GUICtrlCreateCheckbox ("Разрешить хард", 255,90,170,20)
GuiCtrlSetState(-1, 1)

$Label12=GUICtrlCreateLabel ("Буква CD,DVD-диска", 20,120,160,20)
$tab1combo2=GUICtrlCreateCombo ("", 180,120,65,18)
GUICtrlSetData(-1,$cddvd&'|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', $cddvd)
$vkladka1=GUICtrlCreateButton ("Старт", 390,280,87,22, $fokys1)


; ISO
;=============================================================
$tab2=GUICtrlCreateTabitem ("ISO")
GUICtrlCreateLabel ("Конфигурация в gui_qemu.ini.", 30,280,350,20)

$Label20=GUICtrlCreateLabel ("Выделить память, Мб", 20,60,160,20)
GUICtrlSetTip(-1, "Выделить память виртуальному компьютеру")
$tab2combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram3&'|256|512|768|1024', $ram3)

$Label21=GUICtrlCreateLabel ("Выбрать ISO-файл", 20,130,200,20)
GUICtrlSetTip(-1, "Выбрать в списке (gui_qemu.ini)")
$tab2combo1=GUICtrlCreateCombo ("", 20,150,460,18)
_listcombo()

GUICtrlCreateGroup("", 16, 175, 468, 77)
$tab2input=GUICtrlCreateInput ("", 20,190,420,22)
GUICtrlSetState(-1,8)
$isofile=GUICtrlCreateButton ("...", 445,189,35,24)
$save1=GUICtrlCreateButton ("^ Сохранить в список ^", 173,220,140,24)
GUICtrlSetTip(-1, "Сохранение пути в ini-файл"&@CRLF&"и добавить в комбобокс")

$Label23=GUICtrlCreateLabel ("Физический хард (флешка)", 20,90,160,20)
GUICtrlSetTip(-1, "Выбрать доступный HDD, отсчёт с нуля")
$tab2combo3=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive2&'|0|1|2', $Drive2)

$checkCN023=GUICtrlCreateCheckbox ("Разрешить хард", 255,90,170,20)
GuiCtrlSetState(-1, 1)
GUICtrlSetTip($checkCN023, "Некоторые iso требуют хард, другие вылетают с хардом, экспериментируйте с параметром")

$vkladka2=GUICtrlCreateButton ("Старт", 390,280,87,22, $fokys2)



; IMA
;=============================================================
$tab3=GUICtrlCreateTabitem ("IMA")
GUICtrlCreateLabel ("Конфигурация в gui_qemu.ini.", 30,280,350,20)

GUICtrlCreateLabel ("Выделить память, Мб", 20,60,160,20)
GUICtrlSetTip(-1, "Выделить память виртуальному компьютеру")
$tab3combo0=GUICtrlCreateCombo ("", 180,55,65,18)
GUICtrlSetData(-1,$ram4&'|256|512|768|1024', $ram4)

GUICtrlCreateLabel ("Физический хард (флешка)", 20,90,160,20)
GUICtrlSetTip(-1, "Выбрать доступный HDD, отсчёт с нуля")
$tab3combo1=GUICtrlCreateCombo ("", 180,87,65,18)
GUICtrlSetData(-1,$Drive3&'|0|1|2', $Drive3)

$tab3input=GUICtrlCreateInput ("", 40,150,400,22)
GUICtrlSetState(-1,8)
$imafile=GUICtrlCreateButton ("...", 445,149,35,24)

$checkCN033=GUICtrlCreateCheckbox ("Разрешить хард", 255,90,170,20)
GuiCtrlSetState(-1, 1)
GUICtrlSetTip($checkCN033, "Экспериментируйте с параметром")

$vkladka3=GUICtrlCreateButton ("Старт", 390,280,87,22, $fokys3)

; ?
;=============================================================
$tab4=GUICtrlCreateTabitem ("?")
GUICtrlCreateLabel ("Почти все параметры сохраняются в gui_qemu.ini.", 20,40,380,20)
GUICtrlCreateLabel ("Драйвер kqemu.sys необходим для работы QEMU.", 20,60,450,20)
GUICtrlCreateLabel ("Нет загрузки, если указан несуществующий жёсткий диск.", 20,80,450,20)
GUICtrlCreateLabel ("Ctrl+Alt или Windows - освободить курсор.", 20,100,450,20)
GUICtrlCreateLabel ("Если разрешена загрузка с хардом, то только для чтения, не нужно ничего", 20,120,450,20)
GUICtrlCreateLabel ("сохранять, последствия - проверка диска.", 20,140,450,20)
GUICtrlCreateLabel ("AZJIO 17.02.2010", 360,270,100,32)

$zzz=GUICtrlCreateButton ("Переменные", 390+111,40,87,22) ; скрытая тестовая кнопка
GUICtrlSetTip(-1, "Посмотреть переменные на вкладках")

				  ;MsgBox(0, "Readme", $tab3)
				  ;3 6 13 23 39 49

; установка фокуса взависимости от активной вкладки
;GUICtrlSetState(Eval('vkladka' & $vkladka00),16)


GUICtrlSetState(Eval('tab' & $vkladka00),16)

GUICtrlCreateTabitem ("")   ; конец вкладок

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
					MsgBox(0, "Переменные", 'Память на вкладке HDD='&$ram00&' Мб'&@CRLF&'Номер физического диска на вкладке HDD='&$drv00&@CRLF&'Память на вкладке CD,DVD='&$ram10&' Мб'&@CRLF&'Номер физического диска на вкладке CD,DVD='&$drv10&@CRLF&'Память на вкладке ISO='&$ram20&' Мб'&@CRLF&'Путь='&$iso20)
					
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
					$Box20=MsgBox(0, "Ошибка", "Выберите существующий iso-файл.")
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
					If $ima30 = "" Then MsgBox(0, "Ошибка", "Выберите ima-файл.")
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
					$TmpISOFile = FileOpenDialog("Выбор iso-файла.", @WorkingDir & "", "Образ диска (*.iso)", 1 + 4 )
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
					$TmpIMAFile = FileOpenDialog("Выбор ima-файла.", @WorkingDir & "", "Образ флопика (*.ima;*.img)", 1 + 4 )
					GUICtrlSetData($tab3input, $TmpIMAFile)
			Case $msg = $qemuini
				ShellExecute(@ScriptDir&'\gui_qemu.ini', "", @ScriptDir, "")
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd
	
	
; Функция создания списка комбобокса
;=============================================================
Func _listcombo()
$ini1 = FileOpen($Ini, 0) ; Открывается и читаем файл
$ini2 = FileRead($ini1)
FileClose($ini1)
$ini2 = StringReplace($ini2, " ;=", "")
$aISO = StringRegExp($ini2, '(?s)\[iso\]([^\[]*)', 3) ; регулярное выражение для вытаскивания содержимого секции [iso] в массив
$aRecords = StringSplit($aISO[0], @CRLF)
$x=0
$list=''
;составляем список для комбобокса в обратном порядке
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
