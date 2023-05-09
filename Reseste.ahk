; Celeste Reset Script
; By Mach

#NoEnv
#Persistent
#SingleInstance, Force
#Include %A_ScriptDir%\scripts\functions.ahk
#Include %A_ScriptDir%\scripts\Celeste.ahk
#Include %A_ScriptDir%\data\constants.ahk
#Include settings.ahk

SetKeyDelay, 25, 25
SetWinDelay, 1
SetTitleMatchMode, 2
SetBatchLines, -1
Thread, NoTimers ,True

FileDelete, data/log.log

global celeste := new Celeste()

restart() {
    ; sendLog("info", "start reset")
    Send, {r down}
    sleep, 30
    Send, {r Up}
    Send, {c down}
    Sleep, 30
    Send, {c up}
    Sleep, 430
    ; FileRead, last_data, % "C:\Program Files (x86)\Steam\steamapps\common\Celeste\Saves\debug.celeste"
    ; i := 0
    ; While (true)
    ; {
    ; 	FileRead, new_data, % "C:\Program Files (x86)\Steam\steamapps\common\Celeste\Saves\debug.celeste"
    ; 	if (last_data != new_data)
    ; 	{
    ; 		; sendLog("info", "file info different, breaking")
    ; 		Break
    ; 	} else if (i > 100)
    ; 	{
    ; 		; sendLog("info", "max loops reached, returning")
    ; 		return
    ; 	}
    ; 	; sendLog("info", "file info same, waiting to read again")
    ; 	last_data := new_data
    ; 	i++
    ; 	Sleep, 20
    
    ; }
    Send, {Sc029 down}
    sleep, 30
    Send, {Sc029 up}
    Send, {Up down}
    sleep, 30
    Send, {Up up}
    Send, {Enter down}
    sleep, 30
    Send, {Enter up}
    Send, {Sc029 down}
    sleep, 30
    Send, {Sc029 up}
    ; sendLog("info", "finish reset")
    ; IF YOU WANT TO ALSO USE F1 TO MORE QUICKLY RESPAWN
    ; REMOVE SEMICOLONS IN FRONT OF FOLLOWING COMMANDS
    ; sleep, 400
    ; Send, {F1 down}
    ; sleep, 30
    ; Send, {F1 up}
    ; USE AT YOUR OWN RISK, THIS WILL INVALIDATE CERTAIN RUNS (7A, 7B)
}

#Include hotkeys.ahk