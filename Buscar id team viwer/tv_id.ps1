# Elevar permisos si no es administrador
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell -Verb RunAs "-File `"$PSCommandPath`""
    exit
}

# Configuración: ruta del archivo de configuración Zabbix
$configPaths = @(
    "C:\windows\idenPC.cfg",  # Asegurarse de que esta ruta esté incluida
    "C:\zabbix_agentd.conf",
    "C:\Program Files\Zabbix Agent\zabbix_agentd.conf",
    "C:\Program Files (x86)\Zabbix Agent\zabbix_agentd.conf",
    "C:\ProgramData\zabbix_agentd.conf"
)

# Rutas posibles para TeamViewer en registro
$teamViewerPaths = @(
    'HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer',
    'HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\TeamViewer',
    'HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer\Version15',
    'HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer\Version14',
    'HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer\Version13',
    'HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer\Version12',
    'HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\TeamViewer\Version15',
    'HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\TeamViewer\Version14',
    'HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\TeamViewer\Version13',
    'HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\TeamViewer\Version12'
)

# Buscar ruta válida para ClientID en registro
$validPath = $null
foreach ($path in $teamViewerPaths) {
    try {
        $result = reg query "$path" /v ClientID 2>$null
        if ($LASTEXITCODE -eq 0) {
            $validPath = $path
            break
        }
    }
    catch {
        continue
    }
}

# Construir línea UserParameter
if ($validPath) {
    $userParameterLine = "User Parameter=dosi.tw,reg query `"$validPath`" /v ClientID"
} else {
    $userParameterLine = 'User Parameter=dosi.tw,reg query "HKEY_LOCAL_MACHINE\SOFTWARE\TeamViewer" /v ClientID'
}

# Buscar primer archivo válido y añadir línea si no existe
$archivoModificado = $false
foreach ($configPath in $configPaths) {
    if (Test-Path $configPath) {
        $content = Get-Content $configPath -Raw -ErrorAction SilentlyContinue
        if ($content -notmatch [regex]::Escape($userParameterLine)) {
            Add-Content -Path $configPath -Value $userParameterLine -Encoding UTF8 -ErrorAction SilentlyContinue
        }
        $archivoModificado = $true
        break
    }
}

# Si no se modificó ningún archivo, crear el primero con la línea
if (-not $archivoModificado) {
    try {
        Set-Content -Path $configPaths[0] -Value $userParameterLine -Encoding UTF8 -ErrorAction SilentlyContinue
    }
    catch {
        # Silencioso si falla
    }
}

# --- Autodestrucción ---

$vbsScript = @"
WScript.Sleep 2000
Set fso = CreateObject(""Scripting.FileSystemObject"")
On Error Resume Next
fso.DeleteFile ""$($MyInvocation.MyCommand.Path)"", True
fso.DeleteFile WScript.ScriptFullName, True
On Error Goto 0
"@

$tempVbs = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName() + ".vbs")
Set-Content -Path $tempVbs -Value $vbsScript -Encoding ASCII

Start-Process -FilePath "cscript.exe" -ArgumentList "//nologo `"$tempVbs`"" -WindowStyle Hidden

exit