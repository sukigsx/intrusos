# intrusos
---------------------------------------------------
Este script en Bash es un programa que permite comprobar la red local en busca de intrusos. Aquí está el desglose de lo que hace cada parte del script:

## Opciones del menu

- Crear el fichero de IPs permitidas.
    Permite al usuario crear un archivo con direcciones IP permitidas en la red local.

- Ver el fichero de IPs permitidas.
    Muestra las IPs permitidas almacenadas en el archivo.

- Borrar el fichero de IPs permitidas.
    Borra el archivo de IPs permitidas.

- Editar/Añadir IPs al fichero de IPs permitidas.
    Permite al usuario editar o añadir direcciones IP al archivo de IPs permitidas.

- Escanear la red en busca de intrusos.
    Escanea la red en busca de intrusos comparando las IPs activas con las IPs permitidas y muestra cualquier intruso detectado.

- Instalar un servicio para comprobación automática.
    Instala un servicio para la comprobación automática de intrusos, configurando las credenciales de correo electrónico y la frecuencia de comprobación.

- Borrado de datos.
    Borra todos los datos creados por el script, incluyendo los archivos de IPs permitidas, el script de comprobación automática y las tareas programadas.

- Mostrar ayuda.
    Muestra información de ayuda sobre el script y sus opciones.

- Salir.
    Pues eso, salir del script

## El script utiliza comandos como
clear, echo, read, if, case, for, rm, fping, diff, grep, awk, sort, nano, msmtp, cat, sed, crontab, figlet, nmap y otros para realizar diversas operaciones en el sistema y la red local del usuario.
Si no dispone de ellos los intentara instalar por si solo.

# Instalacion
Simple solo hay que ejecutar la orden :

    git clone https://github.com/sukigsx/intrusos.git
y despues entrar al repositorio clonado y ejecutar con la orden

    bash intrusos.sh
o bien

    ./intrusos.sh
Tambien puedes utilizar mi script (ejecutar_escripts), en el cual puedes instalar todos mis script del repositorio.

    git clone https://github.com/sukigsx/ejecutar_scripts.git
# Espero od guste !!!!!!
# ESPERO OS GUSTE !!!!!!!!!!!!!!!!!!
