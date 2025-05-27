# Scripts de Gestión de Servicios y Permisos en Windows

Este repositorio contiene scripts en PowerShell y VBScript para automatizar tareas comunes en sistemas Windows, específicamente para:

- Crear carpetas y asignar permisos de forma dinámica al grupo adecuado ("Usuarios" o "Users").
- Reiniciar servicios de Windows de forma silenciosa y segura.
- Manejar flags de estado (`green.flag` y `red.flag`) para verificar si la operación fue exitosa o fallida.
- Autodestrucción de los scripts después de la ejecución para mantener el sistema limpio.
- Ejecución sin ventanas emergentes ni mensajes para una experiencia totalmente silenciosa.

---

## Contenido

- `crearPermisos.ps1` - Script PowerShell que crea la carpeta `C:\Windows\config`, asigna permisos completos al grupo "Usuarios" o "Users" y crea un flag indicando éxito o error.
- `crearPermisos.vbs` - Script VBScript para ejecutar `crearPermisos.ps1` con privilegios de administrador y oculto, que luego se autodestruye.
- `reiniciarServicio.ps1` - Script PowerShell para reiniciar el servicio "Zabbix Agent 2", creando un flag de estado según el resultado y autodestruyéndose.
- `reiniciarServicio.vbs` - Script VBScript para ejecutar el script PowerShell anterior con privilegios de administrador y en modo oculto, que también se autodestruye.

---

## Uso

1. Coloca los scripts en la carpeta `C:\1\`.
2. Ejecuta los archivos `.vbs` correspondientes para lanzar los scripts PowerShell con permisos elevados y sin mostrar ventanas.
   
   Por ejemplo, para crear permisos:
   ```shell
   C:\1\crearPermisos.vbs
