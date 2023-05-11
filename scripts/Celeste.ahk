; Celeste Reset Script
; By Mach

class Celeste {
    
    __New() {
        this.pid := getCelestePID()
        this.dir := getCelesteDirectoryFromPid(this.pid)
        this.getCelesteKeys()
    }
    
    ILReset() {
        sendLog(LOG_LEVEL_INFO, Format("Resetting IL run"))
        if (saveOnReset || !debugResets) {
            save := debugResets ? Format("{1}Saves\debug.celeste", this.dir) : Format("{1}Saves\{2}.celeste", this.dir, ilRunSlot)
            FileRead, lastData, % save
            
            start := A_TickCount
            While (true) {
                Send, % Format("{Blind}{{1}}{{2}}", this.restartKey, this.confirmKey)
                FileRead, newData, % save
                if (lastData != newData) {
                    ; sendLog(LOG_LEVEL_INFO, "Save detected, continuing IL reset")
                    Break
                } else if (A_TickCount - start > 5000 && 5000 > 0) {
                    ; sendLog(LOG_LEVEL_WARNING, "5000ms reached, continuing IL reset")
                    Break
                }
                lastData := newData
            }
        }
        if (debugResets) {
            Send, % Format("{Blind}{Sc029}{Up}{Enter}{Sc029}")
        }
        if (fastRespawn) {
            Send, % Format("{Blind}{F1}")
        }
    }
    
    fullRunReset() {
        ; sendLog(LOG_LEVEL_INFO, Format("Resetting full run"))
        if (debugResets && !saveOnReset) {
            Send, % Format("{Blind}{Sc029}{o}{Tab}{Enter}{Sc029}{{1} 12}", this.confirmKey)
            Sleep, 1200
        } else {
            save := Format("{1}Saves\{2}.celeste", this.dir, fullRunSlot)
            FileRead, lastData, % save
            
            start := A_TickCount
            While (true) {
                Send, % Format("{Blind}{Esc}{{1} 3}{{2}}", this.downKey, this.confirmKey, this.cancelKey)
                FileRead, newData, % save
                if (lastData != newData) {
                    ; sendLog(LOG_LEVEL_INFO, "Save detected, continuing fullgame reset")
                    Break
                } else if (A_TickCount - start > 5000 && 5000 > 0) {
                    ; sendLog(LOG_LEVEL_WARNING, "5000ms reached, abandoning fullgame reset")
                    Return
                }
                lastData := newData
            }
            Sleep, 1000
        }
        this.startNewFullGame()
    }
    
    startNewFullGame() {
        Send, % Format("{Blind}{{2} 5}{{1} 5}", this.confirmKey, this.upKey)
        Sleep, 900
        Send, % Format("{Blind}{{4} 5}{{2} {3}}{{1}}{{2} 7}{{1}}{{4} 3}", this.confirmKey, this.downKey, fullRunSlot, this.upKey)
        SetKeyDelay, 10, 1
        Send, % Format("{Blind}{{1} 25}", this.confirmKey)
        SetKeyDelay, %keyDelay%, %keyDuration%
    }
    
    getCelesteKeys() {
        ; sendLog(LOG_LEVEL_INFO, Format("Reading settings from ""{1}""", Format("{1}Saves\settings.celeste", this.dir)))
        FileRead, xml, % Format("{1}Saves\settings.celeste", this.dir)
        
        doc := ComObjCreate("MSXML2.DOMDocument.6.0")
        doc.async := false
        doc.loadXML(xml)
        
        downKeys := StrSplit(doc.selectSingleNode("//Settings/MenuDown/Keyboard").text, A_Space)
        upKeys := StrSplit(doc.selectSingleNode("//Settings/MenuUp/Keyboard").text, A_Space)
        confirmKeys := StrSplit(doc.selectSingleNode("//Settings/Confirm/Keyboard").text, A_Space)
        cancelKeys := StrSplit(doc.selectSingleNode("//Settings/Cancel/Keyboard").text, A_Space)
        restartKeys := StrSplit(doc.selectSingleNode("//Settings/QuickRestart/Keyboard").text, A_Space)
        
        this.downKey := getOneExclusiveFromTwoHaystack(downKeys, upKeys, confirmKeys)
        this.upKey := getOneExclusiveFromTwoHaystack(upKeys, downKeys, confirmKeys)
        this.confirmKey := getOneExclusiveFromTwoHaystack(confirmKeys, downKeys, upKeys)
        this.cancelKey := getOneExclusiveFromTwoHaystack(cancelKeys, downKeys, confirmKeys)
        this.restartKey := getOneExclusiveFromTwoHaystack(restartKeys, downKeys, confirmKeys)
        this.downConfirmKey := getOneSharedFromTwoHaystack(downKeys, confirmKeys)
        
        ; sendLog(LOG_LEVEL_INFO, Format("Up key: {1}, down key: {2}, confirm key: {3}, cancel key: {4}, restart key: {5}, down confirm key: {6}", this.upKey, this.downKey, this.confirmKey, this.cancelKey, this.restartKey, this.downConfirmKey))
    }
    
}