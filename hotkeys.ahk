; Celeste Reset Script
; By Mach

RAlt::Suspend ; Pause all macros
RCtrl:: ; Reload if macro locks up
    Reload
return

#If WinActive("ahk_exe Celeste.exe")
    {
        Del:: reset() ; Reset your current run
    }