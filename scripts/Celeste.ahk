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
        save := debugResets ? Format("{1}Saves\debug.celeste", this.dir) : Format("{1}Saves\{2}.celeste", this.dir, ilRunSlot)
        if (saveOnReset || !debugResets) {
            FileRead, lastData, % save
            
            Send, % Format("{Blind}{{1}}{{2}}", this.restartKey, this.confirmKey)
            
            start := A_TickCount
            While (true) {
                FileRead, newData, % save
                if (lastData != newData) {
                    sendLog(LOG_LEVEL_INFO, "Save detected, continuing reset")
                    Break
                } else if (A_TickCount - start > saveCheckTimeout && saveCheckTimeout > 0) {
                    sendLog(LOG_LEVEL_WARNING, "saveCheckTimeout reached, continuing reset")
                    Break
                }
                lastData := newData
                Sleep, 10
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
        sendLog(LOG_LEVEL_INFO, Format("Resetting full run"))
        if (debugResets && !saveOnReset) {
            Send, % Format("{Blind}{Sc029}{o}{Tab}{Enter}{Sc029}")
            Sleep, 10
            Send, % Format("{Blind}{{1} 6}", this.confirmKey)
            Sleep, 900
        } else {
            Send, % Format("{Blind}{Esc}{{1} 3}{{2}}", this.downKey, this.confirmKey)
            Sleep, 1600
        }
        this.startNewSave()
    }
    
    startNewSave() {
        Send, % Format("{Blind}{{1} 5}", this.confirmKey)
        Sleep, 800
        Send, % Format("{Blind}{{4} 5}{{2} {3}}{{1}}{{2} 5}{{1}}{{4} 3}", this.confirmKey, this.downKey, fullRunSlot, this.upKey)
        SetKeyDelay, 10, 15
        Send, % Format("{Blind}{{1} 25}", this.confirmKey)
    }
    
    getCelesteKeys() {
        sendLog(LOG_LEVEL_INFO, Format("Reading settings from ""{1}""", Format("{1}Saves\settings.celeste", this.dir)))
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
        
        sendLog(LOG_LEVEL_INFO, Format("Up key: {1}, down key: {2}, confirm key: {3}, cancel key: {4}, restart key: {5}, down confirm key: {6}", this.upKey, this.downKey, this.confirmKey, this.cancelKey, this.restartKey, this.downConfirmKey))
    }
    
}