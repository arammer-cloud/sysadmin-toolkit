function Get-DiskReport {
    param(
        # parámetro de tipo número entero llamado Threshold, valor por defecto 0
        $Threshold = 0
    )

    $fecha   = Get-Date -Format "yyyy-MM-dd"
    $csvPath = "informe-$fecha.csv"
    $logPath = "errores.log"

    # obtener todos los discos del sistema
    $discos = Get-PSDrive

    foreach ($disco in $discos) {
        try {
            $usado = $disco.Used
            $libre = $disco.Free
            $total = $usado + $libre

            if ($total -gt 0) {
                # calcular el porcentaje redondeado a 1 decimal
                $pct = [math]::Round( $usado / $total * 100, 1 )

                # mostrar solo si supera o iguala el umbral
                if ($pct -ge $Threshold) {
                    $fila = [PSCustomObject]@{
                        Fecha   = $fecha
                        Disco   = $disco.Name
                        UsoPct  = $pct
                        LibreGB = [math]::Round($libre / 1GB, 2)
                    }
                    $fila | Export-Csv -Path $csvPath -NoTypeInformation -Append
                    Write-Host "$($disco.Name): $pct% usado"
                }
            }
        }
        catch {
            $ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            # guardar el error en el log con timestamp
            Add-Content -Path $logPath -Value "[$ts]$($_.Exception.Message)"
        }
    }

    Write-Host "Informe guardado en $csvPath"
}

# llamar a la función mostrando todos los discos
Get-DiskReport

# llamar a la función mostrando solo discos por encima del 50%
Get-DiskReport -Threshold 50