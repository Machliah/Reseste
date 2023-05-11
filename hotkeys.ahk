; Celeste Reset Script
; By Mach

#If WinActive("ahk_exe Celeste.exe")
    {
        Del:: reset() ; Reset your current run using resetType
        
        ; *key*:: reset("IL") ; IL reset
        ; *key*:: reset("full") ; fullgame reset
        ; *key*:: startNewSave() ; start a new save from the main menu (not the title screen)
    }