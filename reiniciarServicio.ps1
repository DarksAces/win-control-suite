Remove-Item "C:\1\green.flag", "C:\1\red.flag" -ErrorAction SilentlyContinue

$flagOK = "C:\1\green.flag"
$flagError = "C:\1\red.flag"

try {
    Stop-Service -Name "Zabbix Agent 2" -ErrorAction Stop
    Start-Sleep -Seconds 5
    Start-Service -Name "Zabbix Agent 2" -ErrorAction Stop
    Start-Sleep -Seconds 2
    New-Item -Path $flagOK -ItemType File -Force | Out-Null
}
catch {
    New-Item -Path $flagError -ItemType File -Force | Out-Null
}

# Autodestrucción del script PowerShell
$scriptPath = $MyInvocation.MyCommand.Path
Remove-Item $scriptPath -Force -ErrorAction SilentlyContinue
