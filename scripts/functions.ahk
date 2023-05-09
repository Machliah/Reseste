; Celeste Reset Script
; By Mach

reset() {
    if (resetType == "IL") {
        celeste.ILReset()
    } else if (resetType == "full") {
        celeste.fullRunReset()
    }
}

sendLog(logLevel, logMsg) {
    timeStamp := A_TickCount
    macroLogFile := FileOpen("data/log.log", "a -rwd")
    
    if (!IsObject(macroLogFile)) {
        logQueue := Func("sendLog").Bind(logLevel, logMsg, timeStamp)
        SetTimer, %logQueue%, -10
        return
    }
    
    macroLogFile.Write(Format("[{3}] [{4}-{5}-{6} {7}:{8}:{9}] [SYS-{2}] {1}`r`n", logMsg, logLevel, timeStamp, A_YYYY, A_MM, A_DD, A_Hour, A_Min, A_Sec))
    macroLogFile.Close()
}

getCelesteDirectoryFromPid(pid) {
    command := Format("powershell.exe $x = Get-WmiObject Win32_Process -Filter \""ProcessId = {1}\""; $x.CommandLine", pid)
    
    ; Get the Celeste.exe directory
    rawOut := runHide(command)
    
    ; Format Celeste path
    dir := StrReplace(SubStr(rawOut, 2, -14), "/", "\")
    
    sendLog(LOG_LEVEL_INFO, Format("Got Celeste directory ""{1}"" from pid: {2}", dir, pid))
    
    return dir
}

getOneExclusiveFromTwoHaystack(needlestack, haystack1, haystack2) {
    for i, needle in needlestack {
        
        1good := True
        for j, hay1 in haystack1 {
            if (needle == hay1) {
                1good := False
            }
        }
        if (!1good) {
            Continue
        }
        
        2good := True
        for k, hay2 in haystack2 {
            if (needle == hay2) {
                2good := False
            }
        }
        if (!2good) {
            Continue
        }
        
        Return needle
    }
}

getOneSharedFromTwoHaystack(haystack1, haystack2) {
    for i, needle in haystack1 {
        for j, hay1 in haystack2 {
            if (needle == hay1) {
                Return needle
            }
        }
    }
}

runHide(Command) {
    DetectHiddenWindows, On
    Run, % ComSpec,, Hide, cPid
    WinWait, % Format("ahk_pid {1}", cPid)
    DetectHiddenWindows, Off
    DllCall("AttachConsole", "uint", cPid)
    
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec(Command)
    result := exec.StdOut.ReadAll()
    
    DllCall("FreeConsole")
    Process, Close, % cPid
    Return result
}

getCelestePID() {
    WinGet, all, list
    Loop, % all {
        WinGet, pid, PID, % Format("ahk_id {1}", all%A_Index%)
        WinGetTitle, title, % Format("ahk_pid {1}", pid)
        if (title == "Celeste") {
            return pid
        }
    }
}