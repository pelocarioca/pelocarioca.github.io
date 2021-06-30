#!/bin/bash
#Nombre del archivo: crear-inventario.sh

#Este código se encuentra licenciado bajo GNU GENERAL PUBLIC LICENSE v3
#Para más información consultar el archivo LICENSE

#Este script crea un archivo de hosts legible por Ansible, para ello detecta
#las máquinas con el puerto 22 abierto de la red del master y las guarda.
#También añade como variable de las máquinas un usuario.

# check if is running as root
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

file=${1:-"/etc/ansible/hosts"}

read -p "Nombre del aula (ASIR1): " aula
aula=${aula:-ASIR1}

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
