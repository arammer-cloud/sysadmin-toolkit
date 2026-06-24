# SysAdmin Toolkit

Colección de scripts de automatización para administración de sistemas Windows y Linux.

## Scripts

### Get-DiskReport (PowerShell)
Analiza el uso de disco de todos los discos Windows y exporta a CSV.
**Uso:** `Get-DiskReport -Threshold 80`

### health-check.sh (Bash)
Monitorización de CPU, RAM, disco y procesos con alertas por color.
Incluye alertas automáticas si CPU supera 80% o disco 90%.
**Uso:** `bash scripts/health-check.sh`

### rotate_logs.sh (Bash)
Limpieza automática de logs con más de 7 días de antigüedad.
Programado con cron para ejecutarse cada noche a medianoche.

## Requisitos
- Windows 10 o superior con PowerShell 5.1
- Ubuntu en WSL2 para los scripts Bash
