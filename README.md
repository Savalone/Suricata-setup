# Suricata-setup

Suricata-Setup.sh facilitara la configuracion inicial de suricata luego de su instalacion, detectando y cambiando automaticamante los campos necesarios para la configuracion basica de suricata, y siguiendo los pasos para poder empezar a utilizar suricata como IDS en pocos segundos.

> Se recomienda hacer un snapshot o guardar el estado de la maquina antes de la ejecucion de el script

---

# Set-IPS-mode.sh

Set-IPS-mode.sh configura automaticamente suricata para actuar en modo IPS, modificando los campos necesarios, y agregando las reglas de firewall pertinentes para que suricata realice su trabajo.

> Es importante resaltar que este script utiliza iptables e iptables-persistent, por lo que si en su configuracion esta usando ufw u otro firewall, se recomienda seguir esta guia para la configuracion:
> https://www.digitalocean.com/community/tutorials/how-to-configure-suricata-as-an-intrusion-prevention-system-ips-on-ubuntu-20-04

---
## Referencias

https://www.digitalocean.com/community/tutorials/how-to-configure-suricata-as-an-intrusion-prevention-system-ips-on-ubuntu-20-04
https://docs.suricata.io/en/latest


