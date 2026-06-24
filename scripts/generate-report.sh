#!/bin/bash

html_path="/home/adm_ramos/sysadmin-toolkit/logs/informe.html"
logs_path="/home/adm_ramos/sysadmin-toolkit/logs"

# Cabecera HTML
cat > $html_path << EOF
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Informe SysAdmin</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f5f5f5; }
        h1 { color: #333; }
        table { border-collapse: collapse; width: 100%; background: white; }
        th { background: #333; color: white; padding: 10px; }
        td { padding: 10px; border-bottom: 1px solid #ddd; text-align: center; }
        .ok { color: green; font-weight: bold; }
        .alerta { color: red; font-weight: bold; }
    </style>
</head>
<body>
<h1>Informe de Métricas del Sistema</h1>
<table>
<tr><th>Fecha</th><th>CPU %</th><th>RAM Libre</th><th>Disco %</th><th>Estado</th></tr>
EOF

# Leer cada JSON y añadir fila
for json in $logs_path/metricas-*.json; do
    fecha=$(cat $json | grep fecha | awk -F'"' '{print $4}')
    cpu=$(cat $json | grep cpu_uso | awk -F'"' '{print $4}')
    ram=$(cat $json | grep ram_libre | awk -F'"' '{print $4}')
    disco=$(cat $json | grep disco_uso_pct | awk -F'"' '{print $4}')

    if [ "$disco" -gt 90 ] || [ "${cpu%.*}" -gt 80 ]; then
        estado='<span class="alerta">ALERTA</span>'
    else
        estado='<span class="ok">OK</span>'
    fi

    echo "<tr><td>$fecha</td><td>$cpu%</td><td>$ram</td><td>$disco%</td><td>$estado</td></tr>" >> $html_path
done

# Pie HTML
cat >> $html_path << EOF
</table>
</body>
</html>
EOF

echo "Informe generado en $html_path"
