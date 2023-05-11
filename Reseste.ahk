; Celeste Reset Script
; By Mach

#NoEnv
#Persistent
#SingleInstance, Force
#Include %A_ScriptDir%\scripts\functions.ahk
#Include %A_ScriptDir%\scripts\Celeste.ahk
#Include settings.ahk

SetKeyDelay, %keyDelay%, 5
SetTitleMatchMode, 2
SetBatchLines, -1
Thread, NoTimers, True

FileDelete, log.log

global LOG_LEVEL_INFO := "INFO"
global LOG_LEVEL_WARNING := "WARN"
global LOG_LEVEL_ERROR := "ERR"

global celeste := new Celeste()

#Include hotkeys.ahk