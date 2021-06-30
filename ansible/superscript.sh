#!/bin/bash
#Nombre del archivo: superscript.sh

#Este código se encuentra licenciado bajo GNU GENERAL PUBLIC LICENSE v3
#Para más información consultar el archivo LICENSE

#Este script lee una serie de variables; grupo, usuario, contraseña, path a las
#claves y archivo de salida y hace lo siguiente:
#~Crea un par de claves ssh rsa de 4096 bits (se puede intentar cambiar pero
#   puede que no funcione).
#~Copia las claves creadas en las máquinas clientes, que son las máquinas de la
#   red local con el puerto 22 abierto. Para ello utiliza la información recogida
#   en las variables:
#   ¡IMPORTANTE! el usuario y contraseña introducidos son tanto los de las
#   máquinas cliente como la de control, es decir que el usurio "ejemplo" debe
#   estar en la máquina master y en las slaves con permisos de administrador
#   (para poder utilizar correctamente los comandos de Ansible.
#~Crea o reescribe un archivo de hosts de Ansible con las direcciones de las
#   máquinas clientes, añade como variables de estas máquinas el usuario y
#   contraseña introducidos.


# comprueba si el usuario que lo ejecuta es ROOT.
[ $(whoami) != root ] && echo "[ERROR] Please, run as root" && exit 1

#Lectura de variables
read -p "Nombre del aula (ASIR1): " aula
aula=${aula:-ASIR1}

read -p "Usuario (profesor): " usuario
usuario=${usuario:-profesor}

read -sp "Contraseña (********): " contra
echo ""
contra=${contra:-roseforp}

read -p "Ruta/Nombre de la clave (~/.ssh/ansible-host-key): " rutakey
rutakey=${rutakey:-~/.ssh/ansible-host-key}
echo "La clave privada se llamará: $rutakey"
rutapub="$rutakey.pub"
echo "La clave pública se llamará: $rutapub"

read -p "Ruta del archivo de salida (/etc/ansible/hosts): " file
file=${1:-"/etc/ansible/hosts"}

#Función con elección de variables a la que volver (pues es multielección).
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

#Función a la que se llega tras la multielección.
function resul {
#Crea el par de claves.
/bin/su --command "ssh-keygen -f ""$rutakey"" -t rsa -b 4096" $usuario

#Comprueba si está instalado sshpass.
which sshpass > /dev/null || apt install -y sshpass

#Ejemplo de direcciones:
#Direcciones=("10.1.1.7" "10.1.1.12" "10.1.1.87")
#Recoge las direcciones y las almacena en un array llamado direcciones.
direcciones=(
$(nmap -p 22 --open -n $(nmcli dev show $(ip route get 8.8.8.8 | grep "dev *" | cut -d" " -f 5) | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5)
)

#Bucle en el que a cada dirección del array se le copia una clave.
for i in "${direcciones[@]}"
do
    #Copia la clave, redirige la salida a un log.
    sshpass -p $contra ssh-copy-id -i $rutapub -o StrictHostKeyChecking=no ${usuario}@$i >> copiar-claves.log
done
contra="o"


    echo "Buscando IPs con el puerto 22 abierto"
    #dev=$(ip route get 8.8.8.8 | grep "dev *" | cut -d" " -f 5)
    #nmap -p 22 --open -n $(nmcli dev show $dev | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5 >> $file
    for i in "${direcciones[@]}"
    do
      echo $i  >> $file
    done


    echo "" >> $file
    echo "Generando variables"
    echo "[$aula:vars]" >> $file
    echo "ansible_user=$usuario" >> $file

    echo "Fichero generado $file:"
    cat $file
    echo "Verifica el ping introducido con: ansible $aula -m ping"
    exit 0
}
elec
