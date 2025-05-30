Option Explicit

Dim fso, shell, scriptDir, ps1File, vbsFile
Dim configPath, userParameterLine, file, content, alreadyExists

' Obtener directorio del script
Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")
scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)

' Archivos a eliminar
ps1File = scriptDir & "\tv_id.ps1"
vbsFile = WScript.ScriptFullName

' Configuración
configPath = "C:\windows\idenPC.cfg"
userParameterLine = "User Parameter=dosi.tw,reg query ""HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer"" /v ClientID"

alreadyExists = False

' Verificar y modificar archivo de configuración
On Error Resume Next
If fso.FileExists(configPath) Then
    Set file = fso.OpenTextFile(configPath, 1) ' ForReading
    If Err.Number = 0 Then
        content = file.ReadAll
        file.Close
        If InStr(content, userParameterLine) > 0 Then
            alreadyExists = True
        End If
    End If
    Err.Clear
End If

' Añadir la línea si no existe
If Not alreadyExists Then
    If fso.FileExists(configPath) Then
        Set file = fso.OpenTextFile(configPath, 8) ' ForAppending
        If Err.Number = 0 Then
            file.WriteLine userParameterLine
            file.Close
        End If
    Else
        Set file = fso.CreateTextFile(configPath, True)
        If Err.Number = 0 Then
            file.WriteLine userParameterLine
            file.Close
        End If
    End If
End If

' Limpiar archivos - crear script de autodestrucción
Dim cleanupCmd
cleanupCmd = "cmd /c timeout /t 2 /nobreak >nul 2>&1"
If fso.FileExists(ps1File) Then
    cleanupCmd = cleanupCmd & " & del """ & ps1File & """ /f /q >nul 2>&1"
End If
cleanupCmd = cleanupCmd & " & del """ & vbsFile & """ /f /q >nul 2>&1"

shell.Run cleanupCmd, 0, False

On Error Goto 0