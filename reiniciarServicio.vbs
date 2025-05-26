' Script VBS para reiniciar servicio con privilegios de administrador
On Error Resume Next

Set objShell = CreateObject("Shell.Application")
Set fso = CreateObject("Scripting.FileSystemObject")

' Ejecutar el archivo .bat con privilegios de administrador
objShell.ShellExecute "cmd.exe", "/c C:\1\reiniciarServicio.bat", "", "runas", 0

' Esperar a que termine la ejecución (más tiempo para el reinicio del servicio)
WScript.Sleep 8000

' Autodestrucción del archivo VBS
scriptPath = WScript.ScriptFullName
Set objShell2 = CreateObject("WScript.Shell")
objShell2.Run "cmd /c timeout /t 2 > nul & del """ & scriptPath & """", 0, False

' Terminar el script
WScript.Quit