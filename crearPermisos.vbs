On Error Resume Next

Dim objShell, fso, scriptPath
Dim greenFlag, redFlag
Dim timeout, startTime, flagFound

Set objShell = CreateObject("Shell.Application")
Set fso = CreateObject("Scripting.FileSystemObject")

psScript = "C:\1\crearPermisos.ps1"
greenFlag = "C:\1\green.flag"
redFlag = "C:\1\red.flag"

' Ejecutar PowerShell como administrador (invisible)
objShell.ShellExecute "powershell.exe", "-ExecutionPolicy Bypass -WindowStyle Hidden -File """ & psScript & """", "", "runas", 0

timeout = 30 ' segundos
startTime = Timer
flagFound = False

Do
    WScript.Sleep 500
    If Timer - startTime > timeout Then Exit Do
    flagFound = fso.FileExists(greenFlag) Or fso.FileExists(redFlag)
Loop Until flagFound

' No crea flags ni borra nada, solo se autodestruye

scriptPath = WScript.ScriptFullName
CreateObject("WScript.Shell").Run "cmd /c timeout /t 2 > nul & del """ & scriptPath & """", 0, False

WScript.Quit
