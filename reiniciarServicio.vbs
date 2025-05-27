' reiniciarServicio.vbs
Dim objShell
Set objShell = CreateObject("WScript.Shell")
&nbsp;
&nbsp;

' Detener el servicio
objShell.Run "sc stop ""Zabbix Agent 2""", 0, True
WScript.Sleep 5000 ' Esperar 5 segundos
&nbsp;
&nbsp;

' Iniciar el servicio
objShell.Run "sc start ""Zabbix Agent 2""", 0, True
WScript.Sleep 2000 ' Esperar 2 segundos