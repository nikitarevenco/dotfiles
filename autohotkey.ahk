#NoEnv
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%

!Left::Send {Home}

!Right::Send {End}

!m::Send {F11}

F1::return

Menu, Tray, Add, Exit, ExitScript
return

ExitScript:
ExitApp
