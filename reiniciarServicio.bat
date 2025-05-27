@echo off
setlocal
sc stop "Zabbix Agent 2" > nul 2>&1
timeout /t 5 > nul
sc start "Zabbix Agent 2" > nul 2>&1
timeout /t 2 > nul
:: Autodestrucción del archivo .bat
(goto) 2>nul & del "%~f0"