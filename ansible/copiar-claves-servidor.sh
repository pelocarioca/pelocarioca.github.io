#!/bin/bash
#Nombre del archivo: copiar-claves-servidor.sh

direcciones=("10.1.1.43" "10.1.1.45" "10.1.1.46" "10.1.1.47")
ruta=~/.ssh/ansible-host-key
usuario=profesor
contrasena=roseforp

for i in "${direcciones[@]}"
do
sshpass -p $contrasena ssh-copy-id -i $ruta -o StrictHostKeyChecking=no ${usuario}@$i
done
