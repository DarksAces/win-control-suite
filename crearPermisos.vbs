
' Script VBS para ejecutar con privilegios de administrador
On Error Resume Next

Set objShell = CreateObject("Shell.Application")
Set fso = CreateObject("Scripting.FileSystemObject")

' Ejecutar el archivo .bat con privilegios de administrador
objShell.ShellExecute "cmd.exe", "/c C:\1\crearPermisos.bat", "", "runas", 0

' Esperar a que termine la ejecución
WScript.Sleep 5000

' Autodestrucción del archivo VBS
scriptPath = WScript.ScriptFullName
Set objShell2 = CreateObject("WScript.Shell")
objShell2.Run "cmd /c timeout /t 2 > nul & del """ & scriptPath & """", 0, False

' Terminar el script
WScript.Quit