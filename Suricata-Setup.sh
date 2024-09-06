#!/bin/bash

# Obtener la IP de la máquina que ejecuta el script
IP_ADDRESS=$(hostname -I | awk '{print $1}')
# Obtener la interfaz de red principal de la máquina
INTERFACE=$(ip route | grep default | awk '{print $5}')

echo "[*] Configurando Suricata con la IP: $IP_ADDRESS y la interfaz: $INTERFACE..."

# Archivo de configuración de Suricata
CONFIG_FILE="/etc/suricata/suricata.yaml"

# Cambiar el valor de HOME_NET
echo "[*] Actualizando el valor de HOME_NET en el archivo de configuración..."
sed -i "s/HOME_NET: \".*\"/HOME_NET: \"[$IP_ADDRESS]\"/" "$CONFIG_FILE"

# Cambiar la interfaz de red principal
echo "[*] Actualizando la interfaz de red principal en el archivo de configuración..."
sed -i "s/- interface: .*/- interface: $INTERFACE/" "$CONFIG_FILE"

# Actualizar las reglas de Suricata
echo "[*] Ejecutando suricata-update para actualizar las reglas..."
suricata-update &> /dev/null 

# Probar las reglas de Suricata
echo "[*] Probando las reglas con suricata -T..."
suricata -T &> /dev/null 

# Reiniciar Suricata después de que todas las tareas se hayan completado
echo "[*] Reiniciando Suricata..."
systemctl restart suricata &> /dev/null 

echo "[+] Configuración de Suricata completada con éxito."

