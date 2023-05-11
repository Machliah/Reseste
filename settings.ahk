; Celeste Reset Script
; By Mach

global resetType := "full" ; What you are resetting for, options include "IL" for individual level resetting and "full" for full run style resetting

global fullRunSlot := 1 ; Run slot to do full runs on (0 is slot 1 and so on) THIS SLOT WILL GET DELETED
global ilRunSlot := 0 ; Run slot used for individual level runs, this option only matters if debugResets are "False"

global debugResets := True ; Significantly faster IL resetting method, will not save game unless saveOnReset is True which will decrease its effectiveness slightly
global fastRespawn := True ; Illegal for certain levels: 6b, 7a, 7b, and 8a
global saveOnReset := True ; Make sure your game saves during a reset (slows down debug resets)

global keyDelay := 35 ; Increase this slightly if macro is messing up
global keyDuration := 15 ; Increasing this can also help if macro is messing up