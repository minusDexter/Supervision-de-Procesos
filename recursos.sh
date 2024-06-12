#!/bin/bash

# Nombre del archivo donde se guardarán las estadísticas
output_file="recursos.csv"

# Obtener el intervalo de tiempo en segundos del usuario
interval=$1

# Verificar si se proporcionó un intervalo
if [ -z "$interval" ]; then
  echo "Por favor, proporciona el intervalo de tiempo en segundos como argumento."
  exit 1
fi

# Escribir el encabezado en el archivo CSV
echo "timestamp,cpu_usage,memory_usage" > "$output_file"

# Función que guarda las estadísticas de CPU y memoria en el archivo
save_stats() {
  while true; do
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
    memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    echo "$timestamp,$cpu_usage,$memory_usage" >> "$output_file"
    sleep "$interval"
  done
}

# Ejecuta la función en segundo plano
save_stats &

