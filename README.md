# Reseste
Celeste Speedrun Reset Macro, yes I know it's a silly name 😭

1. Install the .zip from releases
2. Configure your settings in the settings.ahk file
3. Configure your hotkeys in the hotkeys.ahk file
4. Run the Reseste.ahk file

After changing settings or hotkeys you will need to right click the AHK macro icon in your tray table and select "Reload Script."

## Settings
- resetType : identify reset type between individual level and full save

- fullRunSlot : identify the save slot that full game runs will be reset using (this save gets deleted)
- ilRunSlot : identify the save slot that individual runs will be done on (if you use 'debugResets' this doesn't matter)

- debugResets : use debug console commands to help reset your runs, this setting only really helps speed up IL run resetting. By default this does not save your game. When using with IL resetting you must first manually use a debug console 'load' command
- fastRespawn : press f1 on chapter start to instantly skip the respawning animation for IL resetting, this option is illegal on SRC for the following chapters: 6b, 7a, 7b, and 8a
- saveOnReset : for both reset types, try to save the game before resetting. This option is meant for automatic stat tracking. This will slow down IL resets by a small amount compared to using debugResets and leaving it off and make resetting outside of gameplay for full runs not work. It will not slow down full game reset times compared to debugResets alone and is often faster than just using debugResets

- keyDelay : the time between key presses sent from the macro, increase slightly if macro is consistently messing up
- keyDuration : the length of time a key is pressed down before it is released after being sent, increase slightly if macro is consistently messing up
