#NoEnv
#SingleInstance off
#KeyHistory 0
#include %A_ScriptDir%
ListLines Off
SetWorkingDir %A_ScriptDir%

win := new MainWindow()
win.Show("maximize")
return

#R::Reload

#include UI.ahk
#include GUID.ahk

#include ALD
#include ALD.ahk