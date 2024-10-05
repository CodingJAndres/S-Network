#!/bin/bash

# Definir la red a escanear (puedes cambiarlo según tus necesidades)
NETWORK="192.168.10.0/24"

# Archivo OUI actualizado con nombres de fabricantes y prefijos limpios
OUI_FILE="temp.txt"

# Colores para la salida
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m' # Sin color

# Función para crear un "cajón" visual para cada dispositivo
draw_box() {
    local ip="$1"
    local hostname="$2"
    local mac="$3"
    local manufacturer="$4"
    
    # Tamaño de los campos
    ip_space=20
    hostname_space=20
    mac_space=20
    manufacturer_space=30

    # Crear bordes del cajón
    echo -e "${CYAN}+$(printf "%-${ip_space}s" "" | tr ' ' '-')+$(printf "%-${hostname_space}s" "" | tr ' ' '-')+$(printf "%-${mac_space}s" "" | tr ' ' '-')+$(printf "%-${manufacturer_space}s" "" | tr ' ' '-')+"
    echo -e "${CYAN}| ${GREEN}$(printf "%-${ip_space}s" "$ip")${CYAN}| ${YELLOW}$(printf "%-${hostname_space}s" "$hostname")${CYAN}| ${PURPLE}$(printf "%-${mac_space}s" "$mac")${CYAN}| ${RED}$(printf "%-${manufacturer_space}s" "$manufacturer")${CYAN}|"
    echo -e "${CYAN}+$(printf "%-${ip_space}s" "" | tr ' ' '-')+$(printf "%-${hostname_space}s" "" | tr ' ' '-')+$(printf "%-${mac_space}s" "" | tr ' ' '-')+$(printf "%-${manufacturer_space}s" "" | tr ' ' '-')+"
}

# Escanear la red con `nmap` para obtener los dispositivos conectados y sus direcciones MAC
echo "Escaneando dispositivos en la red $NETWORK..."
echo ""
echo "Dispositivos encontrados:"
echo -e "${CYAN}+--------------------+--------------------+--------------------+------------------------------+"
echo -e "${CYAN}| ${GREEN}IP Address         ${CYAN}| ${YELLOW}Hostname           ${CYAN}| ${PURPLE}MAC Address        ${CYAN}| ${RED}Manufacturer                   ${CYAN}|"
echo -e "${CYAN}+--------------------+--------------------+--------------------+------------------------------+"

# Utilizar `nmap` para escanear la red y obtener los dispositivos conectados
nmap -sP "$NETWORK" | awk '/Nmap scan report/{ip=$NF}/MAC Address:/{mac=$3; vendor=$4; print ip, mac}' > devices.txt

# Leer cada línea de `devices.txt` y extraer la información
while read -r ip mac; do
  if [[ -n $mac ]]; then
    # Extraer los primeros 6 dígitos del MAC (OUI)
    oui=$(echo "$mac" | sed 's/://g' | cut -c 1-6 | tr '[:lower:]' '[:upper:]')

    # Buscar el prefijo en el archivo `nuevo_oui.txt` para obtener el fabricante
    manufacturer=$(grep -i "^$oui" "$OUI_FILE" | cut -d ' ' -f 2-)

    # Si se encontró el fabricante, mostrar el nombre
    if [[ -n $manufacturer ]]; then
      draw_box "$ip" "$ip" "$mac" "$manufacturer"
    else
      draw_box "$ip" "$ip" "$mac" "No Manufacturer Found"
    fi
  else
    # Si no se encuentra dirección MAC, mostrar mensaje
    draw_box "$ip" "No Hostname" "No MAC found" "No Manufacturer Found"
  fi
done < devices.txt

echo -e "${CYAN}+--------------------+--------------------+--------------------+------------------------------+"
echo "Escaneo completado."
