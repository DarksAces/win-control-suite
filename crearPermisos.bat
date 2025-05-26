
@echo off
setlocal

:: Ejecutar el script PowerShell
powershell -ExecutionPolicy Bypass -WindowStyle Hidden -File "C:\1\crearPermisos.ps1"

:: Esperar un momento para asegurar que el script termine
timeout /t 3 > nul

:: Autodestrucción del archivo .bat
(goto) 2>nul & del "%~f0"