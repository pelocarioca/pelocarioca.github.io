#!/bin/bash
#Nombre del archivo: superscript.sh

# check if is running as root
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

#variables
read -p "Nombre del aula (ASIR1): " aula
aula=${aula:-ASIR1}

read -p "Usuario (profesor): " usuario
usuario=${usuario:-profesor}

read -sp "Contraseña (********): " contra
contra=${contra:-roseforp}

read -p "Ruta/Nombre de la clave (~/.ssh/ansible-host-key): " rutakey
rutakey=${rutakey:-~/.ssh/ansible-host-key}
rutapub="$rutakey.pub"
echo "Clave pública generada: $rutapub"

read -p "Ruta del archivo de salida (/etc/ansible/hosts): " file
file=${1:-"/etc/ansible/hosts"}

#Crea el par de claves
ssh-keygen -f "$rutakey" -t rsa -b 4096

#Comprueba si está instalado sshpass
which sshpass > /dev/null || sudo apt install -y sshpass

#Automatizar esto.
direcciones=("10.1.1.7" "10.1.1.12" "10.1.1.87")

#bucle en el que a cada dirección se le copia una clave
for i in "${direcciones[@]}"
do
    #Copia la clave, redirige la salida a un log.
    sshpass -p $contra ssh-copy-id -i $rutapub -o StrictHostKeyChecking=no ${usuario}@$i >> copiar-claves.log
done
contra = "o"

function elec {
    read -p "Sobreescribir el archivo? (y/N/c): " sobre
    sobre=${sobre:-N}

    case $sobre in
      Y*|y*)
        echo "[$aula]" > $file
        resul;;
      N*|n*)
             echo "[$aula]" >> $file
        resul;;
      C*|c*)
        exit;;
      *)
        echo "Vuelve a intentarlo"
        elec;;
    esac
}

function resul {
    echo "Buscando IPs con el puerto 22 abierto"
    dev=$(ip route get 8.8.8.8 | grep "dev *" | cut -d" " -f 5)
    nmap -p 22 --open -n $(nmcli dev show $dev | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5 >> $file

    echo "" >> $file
    echo "Generando variables"
    echo "[$aula:vars]" >> $file
    echo "ansible_user=$usuario" >> $file

    echo "Fichero generado $file:"
    cat $file
    exit 0
}
elec