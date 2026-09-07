#!/bin/bash

# Defino variable de ambiente
if [ -z "$FILENAME" ]; then
    echo "La variable de ambiente FILENAME no esta definida. Indiquela con export FILENAME=nombre de su eleccion"
    exit 1
fi

# Abrevio la ruta del directorio para mejor agilidad
DIR="$HOME/EPNro1"

# Guardo la ruta donde se encuentra menu.sh y consolidar.sh
# dirname obtiene el directorio donde se encuentra el script actual.
# $0 representa el script que estamos ejecutando (menu.sh) y consolidar.sh se encuentra en el mismo directorio.
Dir_consolidar="$(dirname "$0")"

# Condicional que verifica si se ingreso el parametro opcional
if [ "$1" == "-d" ]; then
	if [ -f "$DIR/proceso.pid" ]; then
    	PID=$(cat "$DIR/proceso.pid")
    	kill "$PID"
	fi

    rm -rf "$DIR"
    echo "Directorio eliminado."
    exit 0
fi


#incio en un valor distinto de 7 para que entre al menú por primera vez
opcion=0

while [ "$opcion" != "7" ];
do

	echo
	echo "Menu de opciones:"
	echo "1) Crear entorno"
	echo "2) Correr proceso"
	echo "3) Mostrar alumnos ordenados por padrón"
	echo "4) Mostrar las ultimas 10 notas más altas"
	echo "5) Buscar alumno por padrón"
	echo "6) Visualizar archivo.log"
	echo "7) Salir"

	read -p "Seleccione una opcion: " opcion
	echo

	case $opcion in

	1)
    	mkdir -p "$DIR/entrada" "$DIR/salida" "$DIR/procesado"
    	cp "$Dir_consolidar/consolidar.sh" "$DIR/"
    	echo "El entorno se ha creado en $DIR."
    	;;
	2)
    	if [ -f "$DIR/consolidar.sh" ]; then
        	if [ -f "$DIR/proceso.pid" ]; then
            	echo "Ya se esta ejecutando el proceso en background."
        	else
            	bash "$DIR/consolidar.sh" &
            	echo $! > "$DIR/proceso.pid"
            	echo "consolidar.sh corriendo en segundo plano."
        	fi
    	else
        	echo "Primero debe crear el entorno."
    	fi
    	;;
	3)
    	if [ -f "$DIR/salida/$FILENAME.txt" ]; then
        	sort -n -k1 "$DIR/salida/$FILENAME.txt"
    	else
        	echo "El archivo $FILENAME.txt no existe en salida."
    	fi
    	;;
	4)
    	if [ -f "$DIR/salida/$FILENAME.txt" ]; then
        	sort -k4 -nr "$DIR/salida/$FILENAME.txt" | head -10
    	else
        	echo "El archivo $FILENAME.txt no existe en salida."
    	fi
    	;;
	5)
    	read -p "Ingrese numero de padron: " padron

    	if [ -f "$DIR/salida/$FILENAME.txt" ]; then
        	grep "^$padron " "$DIR/salida/$FILENAME.txt" || echo "Padron no encontrado."
    	else
        	echo "El archivo $FILENAME.txt no existe en salida."
    	fi
    	;;
	6)
    	if [ -f "$DIR/procesado.log" ]; then
        	cat "$DIR/procesado.log"
    	else
        	echo "El archivo procesado.log no existe."
    	fi
    	;;
	7)
    	exit 0
    	;;
	*)
    	echo "opcion invalida. Opciones validas del 1 al 7"
    	;;

	esac
done