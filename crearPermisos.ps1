Remove-Item "C:\1\green.flag", "C:\1\red.flag" -ErrorAction SilentlyContinue

$carpeta = "C:\Windows\config"
$flagOK = "C:\1\green.flag"
$flagError = "C:\1\red.flag"

try {
    if (!(Test-Path $carpeta)) {
        New-Item -Path $carpeta -ItemType Directory -Force | Out-Null
    }

    $grupos = @("Usuarios", "Users")
    $grupoEncontrado = $null

    foreach ($grupo in $grupos) {
        $exists = (net localgroup "$grupo" 2>$null) -ne $null
        if ($exists) {
            $grupoEncontrado = $grupo
            break
        }
    }

    if ($grupoEncontrado) {
        icacls $carpeta /grant "$grupoEncontrado:(OI)(CI)F" /T > $null 2>&1
        New-Item -Path $flagOK -ItemType File -Force | Out-Null
    }
    else {
        New-Item -Path $flagError -ItemType File -Force | Out-Null
    }
}
catch {
    New-Item -Path $flagError -ItemType File -Force | Out-Null
}

Start-Sleep -Seconds 1

# Autodestrucción del script PowerShell
$scriptPath = $MyInvocation.MyCommand.Path
Remove-Item $scriptPath -Force -ErrorAction SilentlyContinue
