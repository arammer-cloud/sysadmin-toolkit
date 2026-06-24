# SysAdmin Toolkit

Colección de scripts de automatización para administración de sistemas Windows.

## Get-DiskReport

Analiza el uso de disco de todos los discos del sistema y exporta el resultado a CSV.

### Uso

.\DiskReport.ps1

Solo discos por encima del 50%:

Get-DiskReport -Threshold 50

Modificar -Threshold para otros resultados

### Requisitos

- Windows 10 o superior
- PowerShell 5.1 o superior

## Health-Check

Analiza el uso de procesos y el estado de un sistema Ubuntu-Linux
