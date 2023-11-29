#!/bin/bash

#Variables de colores, ej. echo -e "${verde} Verificando software necesario.${borra_colores}"
rojo="\e[0;31m\033[1m" #rojo
verde="\e[;32m\033[1m" 
azul="\e[0;34m\033[1m"
amarillo="\e[0;33m\033[1m"
rosa="\e[0;35m\033[1m"
turquesa="\e[0;36m\033[1m"
borra_colores="\033[0m\e[0m" #borra colores


#toma el control al pulsar control + c
trap ctrl_c INT
function ctrl_c()
{
clear
figlet -c Gracias por 
figlet -c utilizar mi
figlet -c script
exit
}

#comprueba actualiczacion del script
actualizar_script(){
archivo_local="intrusos.sh" # Nombre del archivo local
ruta_repositorio="https://github.com/sukigsx/intrusos.git" #ruta del repositorio para actualizar y clonar con git clone

# Obtener la ruta del script
descarga=$(dirname "$(readlink -f "$0")")
git clone $ruta_repositorio /tmp/comprobar >/dev/null 2>&1

diff $descarga/$archivo_local /tmp/comprobar/$archivo_local >/dev/null 2>&1


if [ $? = 0 ]
then
    #esta actualizado, solo lo comprueba
    echo ""
    echo -e "${verde} El script${borra_colores} $0 ${verde}esta actualizado.${borra_colores}"
    echo ""
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
    actualizado="SI"
else
    #hay que actualizar, comprueba y actualiza
    echo ""
    echo -e "${amarillo} EL script${borra_colores} $0 ${amarillo}NO esta actualizado.${borra_colores}"
    echo -e "${verde} Se procede a su actualizacion automatica.${borra_colores}"
    sleep 3
    mv /tmp/comprobar/$archivo_local $descarga
    chmod -R +w /tmp/comprobar
    rm -R /tmp/comprobar
    echo ""
    echo -e "${amarillo} El script se ha actualizado, es necesario cargarlo de nuevo.${borra_colores}"
    echo -e ""
    read -p " Pulsa una tecla para continuar." pause
    exit
fi
}


#comprueba software necesario
software_necesario(){
echo ""
echo -e " Comprobando el software necesario."
echo ""
software="wget git figlet diff fping nano nmap" #ponemos el foftware a instalar separado por espacion dentro de las comillas ( soft1 soft2 soft3 etc )
for paquete in $software
do
which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa llamado programa
sino=$? #recojemos el 0 o 1 del resultado de which
contador="1" #ponemos la variable contador a 1
    while [ $sino -gt 0 ] #entra en el bicle si variable programa es 0, no lo ha encontrado which
    do
        if [ $contador = "4" ] || [ $conexion = "no" ] 2>/dev/null 1>/dev/null 0>/dev/null #si el contador es 4 entre en then y sino en else
        then #si entra en then es porque el contador es igual a 4 y no ha podido instalar o no hay conexion a internet
            clear
            echo ""
            echo -e " ${amarillo}NO se ha podido instalar ${rojo}$paquete${amarillo}.${borra_colores}"
            echo -e " ${amarillo}Intentelo usted con la orden: (${borra_colores}sudo apt install $paquete ${amarillo})${borra_colores}"
            echo -e ""
            echo -e " ${rojo}No se puede ejecutar el script sin el software necesario.${borra_colores}"
            echo ""; read p
            echo ""
            exit
        else #intenta instalar
            echo " Instalando $paquete. Intento $contador/3."
            sudo apt install $paquete -y 2>/dev/null 1>/dev/null 0>/dev/null
            let "contador=contador+1" #incrementa la variable contador en 1
            which $paquete 2>/dev/null 1>/dev/null 0>/dev/null #comprueba si esta el programa en tu sistema
            sino=$? ##recojemos el 0 o 1 del resultado de which
        fi
    done
echo -e " [${verde}ok${borra_colores}] $paquete."
software="SI"
done
}

conexion(){
if ping -c1 google.com &>/dev/null
then
    conexion="SI"
    echo ""
    echo -e " Conexion a internet = ${verde}SI${borra_colores}"
else
    conexion="NO"
    echo ""
    echo -e " Conexion a internet = ${rojo}NO${borra_colores}"
fi
}

#empieza lo gordo
clear
echo ""
conexion
echo ""
if [ $conexion = "SI" ]
then
    #si hay internet
    software_necesario
    actualizar_script
else
    #no hay internet
    software_necesario
fi

sleep 2

while :
do
clear
#maximiza la terminal.
echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
echo ""
echo -e "${verde} Diseñado por sukigsx / Contacto:   scripts@mbbsistemas.es${borra_colores}"
echo -e "${verde}                                    https://repositorio.mbbsistemas.es${borra_colores}"
echo ""
echo -e "${verde} Nombre del script < $0 > Comprueba tu red lan/wifi de Intrusos.  ${borra_colores}"
echo ""
echo -e "     1. ${azul}Crear el fichero de Ip's permitidas..${borra_colores}"
echo -e "     2. ${azul}Ver el fichero de ip's permitidas.${borra_colores}"
echo -e "     3. ${azul}Borrar el fichero de ip's permitidas.${borra_colores}"
echo -e "     4. ${azul}Editar/añadir fichero de ip's permitidas.${borra_colores}"
echo -e "     5. ${azul}Escanear la red..${borra_colores}"
echo ""
echo -e "     6. ${azul}Instalar el servicio en tu maquina (comprobacion automatica).${borra_colores}"
echo -e "     7. ${azul}Desistalar el servicio de tu maquina (comprobacion automatica).${borra_colores}"
echo ""
echo -e "     8. ${azul}Borrado de datos.${borra_colores}"
echo ""
echo -e "    90. ${azul}Ayuda.${borra_colores}"
echo -e "    99. ${azul}Salir.${borra_colores}"
echo ""
echo -n " Seleccione una opcion del menu --->>> "
read opcion
case $opcion in
    
    1)	#crear el fichero ipspermitidas borrando el existente.
		clear
		echo -e "${amarillo}- Introducion de ip's permitidas en la Red. -${borra_colores}"
		echo ""
		echo -e "${rojo}--------------- CUIDADO ----------------"
		echo -e "${rojo}Se borrara la lista y se crea una nueva."
		read -p "Deseas continuar (S/N) -->> " SN
		if [ $SN = "S" ]
		then
            echo ""
            rm /home/$(whoami)/.ipspermitidas 2>/dev/null
            echo -e "${amarillo}Introduce las ip's de una en una y (enter).${borra_colores}"
            echo -e "${amarillo}Las ip's tienen que seguir este formato:${borra_colores}"
            echo -e "${verde}"
            hostname -I | awk '{ print $1 }'
            echo ""
            echo -e "${amarillo}Listado de tus ips activas en la red."
            echo -e "Por si quieres utilizar alguna. Un momento...${borra_colores}"
            echo -e "${verde}"
            rango_red=$(hostname -I | awk '{ print $1 }'); fping -g -a $rango_red/24 2>/dev/null | sort
            echo -e "${borra_colores}"
            for  (( ; ; ))
            do
        		read -p "Dime la ip permitida? (S = Salir) -->> " ips
        		if [[ $ips = "S" || $ips = "s" ]]
        		then
                		break
        		else
                		echo "$ips" >> /home/$(whoami)/.ipspermitidas
                		echo -e "${amarillo}$ips > ${verde}Añadida${borra_colores}"; sleep 1
                		echo ""
        		fi
            done
        else 
            echo ""
            echo -e "${amarillo} Has contestado N o bien lo has puesto en minusculas.${borra_colores}"
            sleep 3
		
        fi
        #quita espacion en blanco del fichero .ipspermitidas
        sed -i 's/ //g' /home/$(whoami)/.ipspermitidas 2>/dev/null
        ;;
        
    2)	#Ver el archivo de ip's permitidas
		clear
		if [ -f /home/$(whoami)/.ipspermitidas ]
		then
            echo -e "${amarillo}Listado de tus ips permitidas.${borra_colores}"
            echo -e "${verde}"
            cat /home/$(whoami)/.ipspermitidas
            echo -e "${borra_colores}"
            echo -e "${amarillo}"
            read -p "Pulsa una tecla para continuar." pause
            echo -e "${borra_colores}"
        else
            clear
            echo -e "${rojo}No existe el fichero ipspermitidas o esta vacio.${borra_colores}"
            echo ""
            echo -e "${amarillo}Crea el fichero primero.${borra_colores}"
            sleep 5
        fi;;
        
    3)	#Borrar el arivo de ip's permitidas
		clear
		if [ -f /home/$(whoami)/.ipspermitidas ]
		then
            echo -e "${rojo}Se va a proceder a borrar el fichero de ips permitidas.${borra_colores}"
            echo ""
            echo -e "${amarillo}Con este contenido de ips.${verde}"
            echo ""
            cat /home/$(whoami)/.ipspermitidas
            echo -e "${rojo}"
            read -p "¿ Quieres borrarlo ? (S/N) -->> " SN
            echo -e "${borra_colores}"
            if [ $SN = "S" ]
            then
                clear
                echo -e "${verde}Fichero borrado.${borra_colores}"
                rm /home/$(whoami)/.ipspermitidas
                sleep 3
            else
                clear
                echo -e "${verde}Perfecto... NO SE BORRA NADA...${borra_colores}"
                sleep 3
            fi
        else
            clear
            echo -e "${rojo}No existe el fichero ipspermitidas o esta vacio.${borra_colores}"
            echo ""
            echo -e "${amarillo}Crea el fichero primero. Opcion 1 del menu.${borra_colores}"
            sleep 5
        fi
        ;;
        
    4)	#editar añadir al fichero de ip's permitidas
		if [[ -f /home/$(whoami)/.ipspermitidas && -s /home/$(whoami)/.ipspermitidas ]]
		then
            echo -e "${amarillo}Editando el fichero ipspermitidas con nano.${borra_colores}"
            clear
            sleep 1
            nano /home/$(whoami)/.ipspermitidas
		else
            clear
            touch /home/$(whoami)/.ipspermitidas 2>/dev/null
            echo -e "${amarillo}Editando el fichero ipspermitidas con nano.${borra_colores}"
            clear
            sleep 1
            nano /home/$(whoami)/.ipspermitidas
		fi
		#quita espacion en blanco del fichero .ipspermitidas
        sed -i 's/ //g' /home/$(whoami)/.ipspermitidas 2>/dev/null
		;;
		
    5)	#escanear la red
        #comprueba que exista el fichero ipspermitidas
        if [[ -f /home/$(whoami)/.ipspermitidas && -s /home/$(whoami)/.ipspermitidas ]]
        then
                echo ""
        else
                clear
                echo -e "${rojo}No dispone fichero con las ip's a comparar.${borra_colores}"
                echo -e "${rojo}O el fichero si existe, pero esta vacio.${borra_colores}"
                echo ""
                #crear el fichero ipspermitidas borrando el existente.
                rm /home/$(whoami)/.ipspermitidas 2>/dev/null
                echo -e "${amarillo}Introduce las ip's de una en una y (enter)."
                echo -e "Las ip's tienen que seguir este formato:${borra_colores}"
                echo ""
                hostname -I | awk '{ print $1 }'
                echo ""
                echo -e "${amarillo}Listado de tus ips activas en la red."
                echo -e "Por si quieres utilizar alguna. Un momento...${borra_colores}"
                echo -e "${verde}"
                rango_red=$(hostname -I | awk '{ print $1 }'); fping -g -a $rango_red/24 2>/dev/null | sort
                echo -e "${borra_colores}"
                for  (( ; ; ))
                do
                        read -p "Dime la ip permitida? ( S = salir) -->> " ips
                        if [[ $ips = "S" || $ips = "s" ]]
                        then
                                if [[ -f /home/$(whoami)/.ipspermitidas && -s /home/$(whoami)/.ipspermitidas ]]
                                then
                                    break
                                else
                                    echo -e "${rojo}El fichero esta vacio.....${borra_colores}"
                                    echo -e "${rojo}Introduce las ips....${borra_colores}"
                                    sleep 3
                                fi
                        else
                                echo "$ips" >> /home/$(whoami)/.ipspermitidas
                                echo -e "${amarillo}$ips > ${verde}Añadida${borra_colores}"; sleep 1
                                echo ""
                        fi
                done
        fi 

        #quita espacion en blanco del fichero .ipspermitidas
        sed -i 's/ //g' /home/$(whoami)/.ipspermitidas 2>/dev/null

        #Detecta los rangos de tu red y los pone en el menu de seleccion
        clear
        echo -e "${azul}Escaneando tu red. Un momento por favor....${borra_colores}"
        echo ""
        rango_red=$(hostname -I | awk '{ print $1 }')

        #captura las ips que estas activas en el mopmento del escaneo y crea el fichero ipsactivas para compararlo con el ipslegales
        rm /tmp/ipsactivas 2>/dev/null
        fping -g $rango_red/24 2> /dev/null | grep alive | awk '{ print $1 }' | sort > /tmp/ipsactivas
        mv /home/$(whoami)/.ipspermitidas ips; cat ips | sort > /home/$(whoami)/.ipspermitidas; rm ips
        #realiza la comprobacion de los ficheros de ipslegales con ipsactivas
        echo -e "${azul}Comprobando las ip's activas con las ip's permitidas${borra_colores}"
        echo ""
        echo -e "${azul}Listado de Ip's Permitidas"
        echo -e "${verde}"
        cat /home/$(whoami)/.ipspermitidas
        diff /home/$(whoami)/.ipspermitidas /tmp/ipsactivas | grep ">" 1>/dev/null
        if [ $? = 0 ]
        then
                echo ""
                while :
                do
                echo -e "${rojo}Intruso's detectados en tu red${borra_colores}"
                echo -e "${rojo}"
                diff /home/$(whoami)/.ipspermitidas /tmp/ipsactivas | grep ">"
                echo -e "${borra_colores}"
                read -p "Saber mas del intruso's, ingresa su ip (99 = Atras) -->> " intruso
                if [ $intruso = 99 ]
                then
                        break
                else
                        nmap -sV  $intruso
                        echo ""
                        echo "Pulsa una tecla para continuar"
                        read pause
                        clear
                fi
                done
        else
                echo ""
                echo -e "${verde}No existen intrusos en tu red.${borra_colores}"
                sleep 5
        fi
        rm /tmp/ipsactivas 2>/dev/null;;

    6)  #instala el servicio, comprobacion automatica
        #comprueba si ya esta instalado el sevicio en crontab
        # Obtén el contenido de la crontab actual
        crontab_content=$(crontab -l 2>/dev/null)

        # Busca la palabra "intrusos" en el contenido de la crontab
        if [[ "$crontab_content" =~ "intrusos" ]]; then
            echo
            echo -e "${amarillo} Ya tienes instalado el servicio.${borra_colores}"
            echo
            echo -e "${verde} Si quieres modificar, primero tienes que desistalar el servicio.${borra_colores}"
            echo -e "${verde} Opcion 7 del menu."
            echo ""
            read -p " Pulsa una tecla para continuar."
            break
        fi

        #comprobacion de ssmtp
        clear
        which msmtp 2>/dev/null 1>/dev/null 0>/dev/null
        msmtp=$?
        while [ $msmtp -gt 0 ]
        do
        echo -e "${rojo} Software necesario NO instalado.${borra_colores}"
        echo -e "${amarillo} Instalando msmtp.${borra_colores}"
        sleep 1
        sudo apt install msmtp msmtp-mta -y 2>/dev/null 1>/dev/null 0>/dev/null
        which msmtp 2>/dev/null 1>/dev/null 0>/dev/null
        msmtp=$?
        done

        clear 
        echo -e "${turquesa}-----------------------------${rojo} MUY IMPORTANTE ${turquesa}-----------------------------${borra_colores}"
        echo ""
        echo -e "${amarillo}Este codigo de script esta pensado para funcionar con una cuenta de google.${borra_colores}"
        echo -e ""
        echo -e "${verde}Si estas utilizando para enviar correos una cuenta SIN doble factor PERFECTO.${borra_colores}"
        echo -e ""
        echo -e "${amarillo}Si estas utilizando una cuenta de correo con el ${rojo}doble factor activado, sigue los siguientes pasos:${borra_colores}"
        echo -e ""
        echo -e "${amarillo}Tendras que crear una clave de aplicacion en dicha cuenta de correo."
        echo -e "es muy sencillo, te muestro los pasos:${borra_colores}"
        echo -e "${azul}"
        echo -e " 1- Entra a la configuracion de la cuenta.(gestionar tu cuenta de google)."
        echo -e " 2- Entra en seguridad. (esta al lado iz)."
        echo -e " 3- En la seccion central (verificacion en dos pasos), entrar en (contraseñas de aplicacion)."
        echo -e " 4- Te pedira tus credenciales."
        echo -e " 5- En (App name) Introduce nombre de aplizacion (ej. intrusios)."
        echo -e " 8- Te saldra una venta con tu contraseña en este formato (xxxx xxxx xxxx xxxx)."
        echo -e " 9- Copiala, y le das a (Hecho). Esa es la contraseña que tienes que poner en el script."
        echo -e ""
        echo -e "${amarillo}Si no te quieres volverte loco y no hacer nada de lo anterior."
        echo -e "Create una cuenta de correo de google y listo, No le pongas segundo factor y ha funcionar.${borra_colores}"
        echo ""

        read -p "Direccion de correo que manda el mail? --> " emailorigen
        read -p "Contraseña del correo $emailorigen -->> " emailpassorigen
        read -p "Direccion a destino de los avisos -->> " emaildestino
        echo ""
        while :
        do
        clear
        echo -e "${azul}Tiempo de comprobacion de intrusos:${borra_colores}"
        echo ""
        echo -e "${azul}   1)${borra_colores} Comprueba cada 0.30 minutos."
        echo -e "${azul}   2)${borra_colores} Comprueba cada 2 horas"
        echo -e "${azul}   3)${borra_colores} Comprueba cada 10 horas"
        echo -e "${azul}   4)${borra_colores} Comprueba cada 24 horas"
        echo ""
        read -p "Dime opcion de tiempo (1,2,3 o 4) -->> " opcion
        case $opcion in
        1)  tiempo=30
            break;;
            
        2)  tiempo=2
            break;;
            
        3)  tiempo=10
            break;;
            
        4)  tiempo=24
            break;;
            
        *)  echo ""
            echo -e "${rojo}Opcion No disponible en el menu menu de tiempo.....${borra_colores}"
            echo -e "${amarillo}Pulsa una tecla para continuar o ( control + c ) salir.${borra_colores}"
            read pause;;
        esac
        done

        #configura el fichero
        rm /tmp/msmtprc 0>/dev/null 1>/dev/null 2>/dev/null

	echo "defaults" >> /tmp/msmtprc
	echo "auth           on" >> /tmp/msmtprc
	echo "tls            on" >> /tmp/msmtprc
	echo "tls_trust_file /etc/ssl/certs/ca-certificates.crt" >> /tmp/msmtprc
	echo "logfile        ~/.msmtp.log" >> /tmp/msmtprc
	echo "account        gmail" >> /tmp/msmtprc
	echo "host           smtp.gmail.com" >> /tmp/msmtprc
	echo "port           587" >> /tmp/msmtprc
	echo "from          root@raspi-buster" >> /tmp/msmtprc
	echo "user           $emailorigen" >> /tmp/msmtprc
	echo "password       $emailpassorigen" >> /tmp/msmtprc
	echo "account default : gmail" >> /tmp/msmtprc

        #cambia la configuracion del fichero ssmtp.conf
        sudo rm /etc/msmtprc 0>/dev/null 1>/dev/null 2>/dev/null
        sudo cp /tmp/msmtprc /etc/
        clear
        echo -e "${amarillo}Enviando correo de prueba...${borra_colores}"
        sleep 1
        echo -e "Subject:Correo de prueba de intrusos.sh\n\n\nEste correo es solo para comprobar que todo funciona.\nBorralo y no le respontas.\n\nContacto: sukigsx@reparaciondesistemas.com\n\nWeb: www.reparaciondesistemas.com\nGithub: www.github.com/sukigsx\n\nMUCHAS GRACIAS POR UTILIZAR MI SCRIPT. " | msmtp $emaildestino 1>/dev/null 2>/dev/null
        if [ $? -ne 0 ]
        then
            echo ""
            echo -e "${rojo}El correo NO ha funcionado.${borra_colores}"
            sleep 3
            ctrl_c
        else
            echo ""
            echo -e "${verde}Correpto, el mail de prueba se ha enviado.${borra_colores}"
            echo -e ""
            echo -e "${azul}Estos son los datos de configuracion:${borra_colores}"
            echo ""
            echo -e "Direccion de corro que manda el mail             =${amarillo} $emailorigen  ${borra_colores}"
            echo -e "Direccion de destino, para el avisos de intrusos =${amarillo} $emaildestino  ${borra_colores}"
            echo -e "Tiempo de comprobacion de estado de intrusos     =${amarillo} $tiempo  ${borra_colores}"
            echo ""
            read -p "¿ Son correptos los datos (S/N) -->> " correpto
            if [[ $correpto = "S" || $correpto = "s" ]] 
            then
                echo -e "${verde}Ok... Continuamos con el proceso.${borra_colores}"
                sleep 2
            else
                ctrl_c
            fi
    
            #comprueba que existan los ficheros de ipsactivas
            if [[ -f /home/$(whoami)/.ipspermitidas && -s /home/$(whoami)/.ipspermitidas ]]
            then
                    echo ""
            else
                    clear
                    echo -e "${rojo}No dispone fichero con las ip's a comparar.${borra_colores}"
                    echo -e "${rojo}O el fichero si existe, pero esta vacio.${borra_colores}"
                    echo ""
                    #crear el fichero ipspermitidas borrando el existente.
                    rm /home/$(whoami)/.ipspermitidas 2>/dev/null
                    echo -e "${amarillo}Introduce las ip's de una en una y (enter)."
                    echo -e "Las ip's tienen que seguir este formato:${borra_colores}"
                    echo ""
                    hostname -I | awk '{ print $1 }'
                    echo ""
                    echo -e "${amarillo}Listado de tus ips activas en la red."
                    echo -e "Por si quieres utilizar alguna. Un momento...${borra_colores}"
                    echo -e "${verde}"
                    rango_red=$(hostname -I | awk '{ print $1 }'); fping -g -a $rango_red/24 2>/dev/null | sort
                    echo -e "${borra_colores}"
                    for  (( ; ; ))
                    do
                            read -p "Dime la ip permitida? (S = Salir) -->> " ips
                            if [[ $ips = "S" || $ips = "s" ]]
                            then
                                    if [[ -f /home/$(whoami)/.ipspermitidas && -s /home/$(whoami)/.ipspermitidas ]]
                                    then
                                        break
                                    else
                                        echo -e "${rojo}El fichero esta vacio.....${borra_colores}"
                                        echo -e "${rojo}Introduce las ips....${borra_colores}"
                                        sleep 3
                                    fi
                            else
                                    echo "$ips" >> /home/$(whoami)/.ipspermitidas
                                    echo -e "${amarillo}$ips > ${verde}Añadida${borra_colores}"; sleep 1
                                    echo ""
                            fi
                    done
        fi 
            
            #Crea el fichero para incluir en el servidor 
            rm /home/$(whoami)/.intrusos_automatico.sh 0>/dev/null 1>/dev/null 2>/dev/null
            descarga=$(dirname "$(readlink -f "$0")")
            sed -n '709,724p' "$0" >> /home/$(whoami)/.intrusos_automatico.sh
            
           echo -e "${amarillo}Configurando la tarea cron automatica.${borra_colores}"
            echo ""
            ####################
            if [ $tiempo = 30 ]
            then
                echo -e "${verde}Configurando en 30 minutos.${borra_colores}"
                echo ""
                echo -e "${verde}Cada 30m se comprobara la red en busca de intrusos.${borra_colores}"
                (crontab -l 2>/dev/null; echo "#Configuracion intrusos_automatico cada 30 minutos") | crontab -
                (crontab -l 2>/dev/null; echo "30 * * * * bash /home/$(whoami)/.intrusos_automatico.sh") | crontab -
                sleep 7
                ctrl_c
            else
                echo ""
            fi
            #############
            if [ $tiempo = 2 ]
            then
                echo -e "${verde}Configurando en 2 horas.${borra_colores}"
                echo ""
                echo -e "${verde}Cada 2 horas se comprobara la red en busca de intrusos.${borra_colores}" 
                (crontab -l 2>/dev/null; echo "#Configuracion intrusos_automatico cada 2 horas") | crontab -
                (crontab -l 2>/dev/null; echo "* */2 * * * bash /home/sukigsx/.intrusos_automatico.sh") | crontab -
                sleep 7
                ctrl_c
            else
                echo ""
            fi
            
            ################3
            if [ $tiempo = 10 ]
            then
                echo -e "${verde}Configurando en 10 horas.${borra_colores}"
                echo ""
                echo -e "${verde}Cada 10 horas se comprobara la red en busca de intrusos.${borra_colores}" 
                (crontab -l 2>/dev/null; echo "#Configuracion intrusos_automatico cada 10 horas") | crontab -
                (crontab -l 2>/dev/null; echo "* */10 * * * bash /home/sukigsx/.intrusos_automatico.sh") | crontab -
                sleep 7
                ctrl_c
            else
                echo ""
            fi
            
            ####################3
            if [ $tiempo = 24 ]
            then
                echo -e "${verde}Configurando en 24 horas.${borra_colores}"
                echo ""
                echo -e "${verde}Cada 24 horas se comprobara la red en busca de intrusos.${borra_colores}" 
                (crontab -l 2>/dev/null; echo "#Configuracion intrusos_automatico cada 24 horas") | crontab -
                (crontab -l 2>/dev/null; echo "* */24 * * * bash /home/sukigsx/.intrusos_automatico.sh") | crontab -
                sleep 7
                ctrl_c
            else
                echo ""
            fi
            
        fi;;

    7)  #desistalar el servicio
        echo ""
        read -p " Seguro que quieres desistalar el servicio? (S/n) -->> " sn
        if [[ $sn = "S" || $sn = "s" ]]
        then
            rm /home/$(whoami)/.intrusos_automatico.sh 0>/dev/null 1>/dev/null 2>/dev/null
            sudo sed -i '/intrusos/d' /var/spool/cron/crontabs/$(whoami) 0>/dev/null 1>/dev/null 2>/dev/null
            echo ""
            echo -e "${verde} Servicio desistalado.${borra_colores}"
            echo ""
            sleep 3
        else
            echo ""
            echo -e "${amarillo} OK, cancelado. ${borra_colores}"
            echo ""
            sleep 3
        fi
        ;;

    8)  #borrado de datos
        clear
        echo -e ""
        echo -e "${rojo}-- Ojo, CUIDADO, Borrado de datos --${borra_colores}"
        echo ""
        echo -e "${amarillo}Se procedera al borrado de todos los ficheros creados por"
        echo -e "este script ( $0 ). Asi como la desistalacion del "
        echo -e "software instalado por el mismo. Y tambien se eliminara el "
        echo -e "contenido del fichero de crontab.${borra_colores}"
        echo -e ""
        echo -e "${amarillo}- ${rojo}Vaciado del fichero (crontab)."
        echo -e "${amarillo}- ${rojo}Borrado de los fichero (ipspermitidas)."
        echo -e "${amarillo}- ${rojo}Desistalacion de (Nmap, fping, ssmtp, mail)."
        echo ""
        read -p "¿ Seguro de borrar todo ? ( mays S/N ) -->> " sn
        if [ $sn = "S" ] 0>/dev/null 1>/dev/null 2>/dev/null
        then 
            echo ""
            echo -e "${rojo}Borrando......Un momento......${borra_colores}"
            rm /home/$(whoami)/.ipspermitidas 0>/dev/null 1>/dev/null 2>/dev/null
            rm /home/$(whoami)/.intrusos_automatico.sh 0>/dev/null 1>/dev/null 2>/dev/null
            sudo apt update 0>/dev/null 1>/dev/null 2>/dev/null
            sudo apt remove nmap fping ssmtp mailutils -y 0>/dev/null 1>/dev/null 2>/dev/null
            sudo apt purge nmap fping ssmtp mailutils -y 0>/dev/null 1>/dev/null 2>/dev/null
            sudo apt clean nmap fping ssmtp mailutils -y 0>/dev/null 1>/dev/null 2>/dev/null
            sudo sed -i '/intrusos/d' /var/spool/cron/crontabs/$(whoami) 0>/dev/null 1>/dev/null 2>/dev/null
            echo ""
            echo -e "${verde}Ok... ¡¡ TODO BORRADO !!${borra_colores}"
            sleep 3
            ctrl_c
        else
            echo ""
            echo -e "${verde}OK.. No se borra nada.${borra_colores}"
            sleep 3
        fi;;
        
    90)	#ayuda
		clear
        echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
        echo -e "${azul} Contacto:${amarillo} sukisx.mbsistemas@.com"
        echo -e "           mbsistemas.ddns.net${borra_colores}"
        echo "-----------------------------------------------------------"
        echo -e "${azul} Nombre del script -->>${amarillo} $0 ${borra_colores}"
        echo ""
       	echo -e "${verde}- MENU AYUDA -${borra_colores}"
		echo ""
		echo -e "${verde}Notas a tener en cuenta:${borra_colores}"
		echo -e "${verde}Este escript le hacen falta algunos programas para su funcionamiento.${borra_colores}"
		echo -e "${verde}Que son los siguienetes:${borra_colores}"
		echo ""
		echo -e "${verde} 1- nmap   >  para escanear a los intrusos.${borra_colores}"
		echo -e "${verde} 2- nano   >  editor para poder modificar tus ip's permitidas.${borra_colores}"
		echo -e "${verde} 3- fping  >  Para escanear la red.${borra_colores}"
		echo -e "${verde} 4- ssmtp  >  Para configurar correo electronico.${borra_colores}"
		echo -e "${verde} 5- mail   >  Para poder mandar correos electronicos.${borra_colores}"
		echo -e "${verde} 6- figlet >  Para los logos.${borra_colores}"
		echo -e "${verde} 7- diff   >  Utilizado para la actualizacion del script.${borra_colores}"
		echo -e "${verde} 8- git    >  Utilizado para la actualizacion del script.${borra_colores}"
		echo -e "${verde} 9- wget   >  Utilizado para la actualizacion del script.${borra_colores}"
		echo ""
		echo -e "${verde}El fichero que se crea con tus ips permitidas se aloja como${borra_colores}"
		echo -e "${verde}fichero oculto en tu home (/home/tu_usuario/.ipspermitidas).${borra_colores}"
		echo -e "${verde}Y tambien el fichero de tarea automatica (/home/tu_usuario/.intrusos_automatico.sh).${borra_colores}"
		echo ""
		echo -e "${verde}El fichero de ips activas en tu red, se aloja en el direcctorio${borra_colores}"
		echo -e "${verde}temporal de tu sistema, (/tmp) asi se borrara si no lo hace el script${borra_colores}"
		echo -e "${verde}por algun fallo, automaticamente cuando reinicies tu sistema.${borra_colores}"
		echo ""
		read -p "Pulsa una tecla para continuar" pause
		clear
        echo -e "${rosa}"; figlet -c sukigsx; echo -e "${borra_colores}"
        echo -e "${azul} Contacto:${amarillo} sukigsx.mbsistemas@gmail.com"
        echo -e "           mbsistemas.ddns.net${borra_colores}"
        echo "-----------------------------------------------------------"
        echo -e "${azul} Nombre del script -->>${amarillo} $0 ${borra_colores}"
        echo ""
		echo -e "${verde}-OPCIONES DEL SCRIPT -${borra_colores}"
		echo ""
		echo -e " ${amarillo} 1)${borra_colores} Crear el fichero de Ip's permitidas."
        echo -e "${verde}       Insertar las ips permitidas de tu red,${borra_colores}"
        echo -e "${verde}       para que no te las muestre como intruso.${borra_colores}"
        echo -e " ${amarillo} 2)${borra_colores} Ver el fichero de ip's permitidas."
        echo -e "${verde}       Te lista las ips permitidas que tienes activadas.${borra_colores}"
        echo -e " ${amarillo} 3)${borra_colores} Borrar el fichero de ip's permitidas."
        echo -e "${verde}       Borra el fichero completo de las ips que tienes permitidas.${borra_colores}"
        echo -e " ${amarillo} 4)${borra_colores} Editar/añadir fichero de ip's permitidas."
        echo -e "${verde}       Te permite editar el fichero, para que metas las ips${borra_colores}"
        echo -e "${verde}       manualmente o varias con corta y pega.${borra_colores}"
        echo -e " ${amarillo} 5)${borra_colores} Escanear la red."
        echo -e "${verde}       Comienza el escaneo de la red,${borra_colores}"
        echo -e "${verde}       y te da la posibilidad si hay intrusos poder escanearlos.${borra_colores}"
        echo -e " ${amarillo} 6)${borra_colores} Instalar servicio en tu maquina (comprobacion automatica)."
        echo -e "${verde}       Realiza la configuracion del correo electronico${borra_colores}"
        echo -e "${verde}       y configura el escaneo de la red de forma automatica.${borra_colores}"
        echo -e " ${amarillo} 7)${borra_colores} Borrado de datos."
        echo -e "${verde}       Realiza el borrado y desistalacion de los datos y software.${borra_colores}"
        echo -e "${verde}       Tambien realiza el vaciado del fichero de crontab.${borra_colores}"
        echo -e " ${amarillo} 8)${borra_colores} Ayuda."
        echo -e "${verde}       Sencillo, lo que estas viendo ahora.${borra_colores}"
        echo -e " ${amarillo}99)${borra_colores} Salir.${borra_colores}"
        echo -e "${verde}       Sencillo tambien, sale del script, borrando las ips activas.${borra_colores}"
		echo ""
		read -p "Pulsa una tecla para continuar" pause;;
                
    99) #salida
        ctrl_c;;

    *)  #se activa cuando se introduce una opcion no controlada del menu
        echo "";
        echo -e " ${amarillo}OPCION NO DISPONIBLE EN EL MENU.    Seleccion 0, 1, 2, 3, 4, 5, 6,7, 90 o 99 ${borra_colores}";
        echo -e " ${amarillo}PRESIONA ENTER PARA CONTINUAR ........${borra_colores}";
        echo "";
        read pause;;
esac
done

#codifo dentro de la funcion para el fichero de .intrusos_automatico.sh
function nousar()
{
cd /home/$(whoami)/
rango_red=$(hostname -I | awk '{ print $1 }')

#captura las ips que estas activas en el mopmento del escaneo y crea el fichero ipsactivas para compararlo con el ipslegales
rm /tmp/ipsactivas 2>/dev/null
fping -g $rango_red/24 2> /dev/null | grep alive | awk '{ print $1 }' | sort > /tmp/ipsactivas
mv /home/$(whoami)/.ipspermitidas ips; cat ips | sort > /home/$(whoami)/.ipspermitidas; rm ips
#realiza la comprobacion de los ficheros de ipslegales con ipsactivas
intrusos_detectados=$(diff /home/$(whoami)/.ipspermitidas /tmp/ipsactivas | grep ">")
if [ $? = 0 ]
then
    echo -e "Subject:Se han detectado intrusos en tu red.\n\nTu script de control de intrusos a detectados las siguientes ip's.\n\n$intrusos_detectados\n\n\nContacto: sukigsx.mbsistemas@gmail.com\nWeb: mbsistemas.ddns.net\nGithub: www.github.com/sukigsx\n\nMUCHAS GRACIAS POR UTILIZAR MI SCRIPT." | msmtp sukigsx@gmail.com
else
    echo
fi
rm /tmp/ipsactivas 0>/dev/null 1>/dev/null 2>/dev/null
}

