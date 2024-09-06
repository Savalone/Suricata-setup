# Suricata-Setup

`Suricata-Setup.sh` facilita la configuración inicial de Suricata después de su instalación, detectando y ajustando automáticamente los parámetros necesarios para su configuración básica. Este script permite comenzar a usar Suricata como un Sistema de Detección de Intrusos (IDS) en pocos segundos.
> Recomendación: Realice un snapshot o guarde el estado de su máquina antes de ejecutar el script.

## Uso

Para ejecutar el script directamente desde el repositorio:
```bash
curl -sSL https://raw.githubusercontent.com/Savalone/Suricata-setup/main/Suricata-Setup.sh | sudo bash
```

## Alternativamente
```bash
wget https://raw.githubusercontent.com/Savalone/Suricata-setup/main/Suricata-Setup.sh
chmod +x Suricata-Setup.sh
sudo ./Suricata-Setup.sh
```
---
# Set-IPS-mode

`Set-IPS-mode.sh`  configura automáticamente Suricata para operar en modo de Sistema de Prevención de Intrusos (IPS). Modifica los parámetros necesarios y agrega las reglas de firewall correspondientes para que Suricata pueda funcionar correctamente en este modo.
> Nota: Este script utiliza iptables y iptables-persistent. Si utiliza ufw u otro firewall, es recomendable seguir [esta guia](https://www.digitalocean.com/community/tutorials/how-to-configure-suricata-as-an-intrusion-prevention-system-ips-on-ubuntu-20-04) para una configuración adecuada.

## Uso
Para ejecutar el script directamente desde el repositorio:
```bash
curl -sSL https://raw.githubusercontent.com/Savalone/Suricata-setup/main/Set-IPS-mode.sh | sudo bash 
```

## Alternativamente
```bash
wget https://raw.githubusercontent.com/Savalone/Suricata-setup/main/Set-IPS-mode.sh
chmod +x Set-IPS-mode.sh
sudo ./Set-IPS-mode.sh
```
