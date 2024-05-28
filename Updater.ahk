SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

UrlDownloadToFile, https://raw.githubusercontent.com/JuWi39/Helldivers2/main/HellDivers2.ahk, Helldivers2.ahk
msgbox, Update Successful
