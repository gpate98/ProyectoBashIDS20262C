#!/bin/bash

DIR="$HOME/EPNro1"


while [ -d "$DIR/entrada" ]
do

    for archivo in "$DIR/entrada"/*.txt
    do
            if [ -f "$archivo" ]; then
                nombre=$(basename "$archivo")    #basename me deja quedarme con el nombre final de una ruta, quitando los directorios
                cat "$archivo" >> "$DIR/salida/$FILENAME.txt"
                mv "$archivo" "$DIR/procesado/"
                echo "$(date '+%d/%m/%Y %H:%M:%S') - Procesado archivo $nombre" >> "$DIR/procesado.log"
            fi
    done
    #Pausar por 30 minutos el ciclo. Modificar valor para reducir o aumentar el tiempo de la pausa
    sleep 30m

done