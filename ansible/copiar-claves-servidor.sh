#!/bin/bash
#Nombre del archivo: copiar-claves-servidor.sh
#Este script copia una clave pública en las máquinas cliente, que son las
#máquinas que se encuentran en la red del master con el puerto 22 abierto.

#Comprueba si está instalado sshpass, en caso de que no lo intenta instalar.
which sshpass > /dev/null || sudo apt install -y sshpass

#Variables para la ejecución.
direcciones=(
$(nmap -p 22 --open -n $(nmcli dev show $(ip route get 8.8.8.8 | grep "dev *" | cut -d" " -f 5) | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5)
)
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
