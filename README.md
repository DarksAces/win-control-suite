# Scripts de Automatización para Windows  
**Windows Automation Scripts**

Este conjunto de scripts permite automatizar tareas administrativas en sistemas Windows. Están diseñados para facilitar despliegues, configuraciones y mantenimientos sin intervención manual repetitiva.

This set of scripts automates administrative tasks on Windows systems. They simplify deployments, configurations, and maintenance with minimal manual effort.

---

## 🧩 Funcionalidades / Features

- Creación de carpetas estructuradas  
  Structured folder creation

- Asignación automática de permisos  
  Automated permission assignment

- Despliegue/movimiento de aplicaciones  
  Application deployment/movement

- Reinicio controlado de servicios del sistema  
  Controlled restart of system services

---

## 📂 Ubicación de los scripts / Script Location

Puedes colocar los scripts en cualquier carpeta del sistema. Se recomienda usar una ruta estándar (como `C:\1\script`) para facilitar la organización, pero no es obligatorio.

You can place the scripts in any folder on the system. Using a standard path (such as `C:\1\script`) is recommended for consistency, but not required.

> ⚠️ Asegúrate de que las rutas internas estén configuradas correctamente en los scripts si cambias su ubicación.  
> ⚠️ Make sure internal paths are configured correctly in the scripts if you change their location.

---

## ▶️ Ejecución / Execution

Ejecutar `launch.bat` con privilegios de administrador.  
Run `launch.bat` with administrator privileges.

---

## ⚠️ Requisitos / Requirements

- Windows 10, 11 o Server  
- PowerShell 5.1+  
- Ejecución de scripts habilitada (`Set-ExecutionPolicy`)  
- Usuario con permisos elevados  

---

## 🛠️ Personalización / Customization

Puedes adaptar los scripts según tus necesidades cambiando:
- Rutas y nombres de carpetas
- Servicios a reiniciar
- Usuarios y grupos para permisos
- Aplicaciones a mover o reinstalar

You can customize the scripts by modifying:
- Paths and folder names  
- Services to restart  
- Users and groups for permissions  
- Applications to move or reinstall
