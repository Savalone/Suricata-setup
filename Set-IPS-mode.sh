#!/bin/bash

# Función para mostrar la barra de progreso
show_progress() {
    local duration=$1
    local interval=0.1
    local count=0
    tput civis  # Oculta el cursor

    while [ $count -le 100 ]; do
        printf "\r["
        for i in $(seq 1 $count); do
            printf "#"
        done
        for i in $(seq $((count + 1)) 100); do
            printf "-"
        done
        printf "] %d%%" $count
        sleep $interval
        count=$((count + duration))
    done

    printf "\n"
    tput cnorm  # Restaura el cursor
}

# Archivo de configuración de Suricata
file="/etc/default/suricata"

echo "[*] Configurando Suricata..."
sed -i '/^LISTENMODE=af-packet/s/^/#/' "$file"
echo "LISTENMODE=nfqueue" >> "$file"
systemctl restart suricata.service

# Mostrar barra de progreso por 2 segundos mientras se reinicia Suricata
show_progress 2

# Verificar el estado de Suricata
echo "[*] Verificando el estado de Suricata..."
if systemctl status suricata | grep -q "Starting suricata in IPS (nfqueue) mode... done"; then
    echo "[+] Suricata configurado correctamente en modo IPS."

    # Reemplazar la regla específica de alert a drop
    rules="/var/lib/suricata/rules/suricata.rules"
    sed -i '/alert ip any any -> any any (msg:"GPL ATTACK_RESPONSE id check returned root"; content:"uid=0|28|root|29|"; classtype:bad-unknown; sid:2100498; rev:7; metadata:created_at 2010_09_23, updated_at 2019_07_26;)/s/^alert/drop/' "$rules"

    # Recargar reglas en Suricata
    kill -USR2 $(pidof suricata)
    systemctl restart suricata

    # Mostrar barra de progreso mientras se reinicia Suricata
    show_progress 2

    # Configurar reglas de iptables
    echo "[*] Configurando reglas de iptables..."
    iptables -I INPUT 1 -p tcp --dport 22 -j NFQUEUE --queue-bypass
    iptables -I OUTPUT 1 -p tcp --sport 22 -j NFQUEUE --queue-bypass
    iptables -I FORWARD -j NFQUEUE
    iptables -I INPUT 2 -j NFQUEUE
    iptables -I OUTPUT 2 -j NFQUEUE

    # Comprobar si el IPS está configurado correctamente
    if curl --max-time 5 http://testmynids.org/uid/index.html &> /dev/null; then
        echo "[+] ERROR: Fallo en la configuración del IPS."
    else
        echo "[+] IPS configurado con éxito... Guardando configuraciones."

        # Guardar reglas de iptables
        mkdir -p /etc/iptables
        iptables-save > /etc/iptables/rules.v4
        ip6tables-save > /etc/iptables/rules.v6

        # Instalar iptables-persistent de forma no interactiva
        if ! dpkg -l | grep -q iptables-persistent; then
            echo "Instalando iptables-persistent..."
            export DEBIAN_FRONTEND=noninteractive
            apt-get install -y iptables-persistent &

            # Mostrar barra de progreso mientras se instala iptables-persistent
            show_progress 3
        fi
    fi
else
    echo "[-] ERROR: Problema al configurar Suricata en modo IPS."
fi