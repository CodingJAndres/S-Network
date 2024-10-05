# Script de Escaneo de Red en Bash

Este script escanea una red local para identificar los dispositivos conectados, mostrando sus direcciones IP, nombres de host, direcciones MAC y fabricantes. Utiliza `nmap` para el escaneo y un archivo OUI para la identificación de los fabricantes.

## Requisitos

- Bash
- `nmap`
- Un archivo OUI (`temp.txt`) con nombres de fabricantes y prefijos limpios. Puedes descargar una lista de OUI desde [Aquí](http://standards-oui.ieee.org/oui.txt).

## Características

- Escanea la red definida para identificar dispositivos conectados.
- Muestra información estructurada en un formato de "cajón" visual.
- Soporta colores para una mejor legibilidad en la salida.
- Permite cambiar fácilmente la red a escanear.

## Instalación

1. Clona o descarga este repositorio.
2. Asegúrate de tener `nmap` instalado en tu sistema. Puedes instalarlo utilizando:

   ```bash
   sudo apt install nmap
   ```

3. Crea un archivo llamado `temp.txt` en el mismo directorio que el script, conteniendo la información OUI.

## Uso

1. Abre una terminal y navega hasta el directorio donde se encuentra el script.
2. Modifica la variable `NETWORK` en el script para especificar la red a escanear, si es necesario.
3. Ejecuta el script con el siguiente comando:

   ```bash
   bash scan_network.sh
   ```


## Ejemplo de Salida

```
Escaneando dispositivos en la red 192.168.10.0/24...

Dispositivos encontrados:
+--------------------+--------------------+--------------------+------------------------------+
| IP Address         | Hostname           | MAC Address        | Manufacturer                   |
+--------------------+--------------------+--------------------+------------------------------+
| 192.168.10.2       | device1            | 00:1A:2B:3C:4D:5E  | Example Manufacturer           |
| 192.168.10.3       | device2            | 00:1B:2C:3D:4E:5F  | Another Manufacturer           |
+--------------------+--------------------+--------------------+------------------------------+
Escaneo completado.
```

## Contribuciones

Las contribuciones son bienvenidas. Si tienes sugerencias o mejoras, no dudes en enviar un pull request.

## Licencia

Este script es de uso libre. Modifícalo y compártelo como desees.
