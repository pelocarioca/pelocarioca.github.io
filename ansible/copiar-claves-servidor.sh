#!/bin/bash
#Nombre del archivo: copiar-claves-servidor.sh

#Comprueba si está instalado sshpass
which sshpass > /dev/null || sudo apt install -y sshpass

#Variables para la ejecución.
direcciones=("10.1.1.7" "10.1.1.12" "10.1.1.87")
ruta=~/.ssh/ansible-host-key.pub
usuario=profesor
#Esto hay que ocultarlo de alguna forma.
contrasena=roseforp

#bucle en el que a cada dirección se le copia una clave
for i in "${direcciones[@]}"
do
    #Copia la clave, redirige la salida a un log.
    sshpass -p $contrasena ssh-copy-id -i $ruta -o StrictHostKeyChecking=no ${usuario}@$i >> copiar-claves.log
done
