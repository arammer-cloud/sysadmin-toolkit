#!/bin/bash
ROJO='\033[0;31m'
VERDE='\033[0;32m'
AMARILLO='\033[1;33m'
SIN_COLOR='\033[0m'

# Fecha y hora actual

fecha=$(date "+%Y-%m-%d %H:%M:%S")
echo "=== Health Check - $fecha ==="
echo ""

# CPU - línea de idle del comando top

echo "--- CPU ---"
cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}')
cpu_uso=$(echo "100 - $cpu_idle" | bc)
echo -e "${VERDE}CPU en uso: $cpu_uso%${SIN_COLOR}"

# RAM
echo "--- RAM ---"
ram_libre=$(free -h | grep "Mem" | awk '{print $4}')
echo -e "${VERDE}RAM libre: $ram_libre${SIN_COLOR}"

# Disco
echo "--- DISCO ---"
disco=$(df -h | grep "^/dev/sdd")
echo -e "${VERDE}$disco${SIN_COLOR}"

# PROCESOS
echo "--- PROCESOS ---"
echo -e "${AMARILLO}PROCESOS${SIN_COLOR}"
ps aux --sort=-%cpu | head -6 | tail -5
echo ""

# Alertas
UMBRAL_CPU=80
UMBRAL_DISCO=90

cpu_numero=$(echo "$cpu_uso" | awk -F. '{print $1}')
disco_uso=$(df / | tail -1 | awk '{print $5}' | tr -d '%')

if [ "$cpu_numero" -gt "$UMBRAL_CPU" ]; then
    echo -e "${ROJO}ALERTA: CPU por encima del $UMBRAL_CPU%${SIN_COLOR}"
fi

if [ "$disco_uso" -gt "$UMBRAL_DISCO" ]; then
    echo -e "${ROJO}ALERTA: Disco por encima del $UMBRAL_DISCO%${SIN_COLOR}"
fi

echo "=== Fin del reporte ==="
