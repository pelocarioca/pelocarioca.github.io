#!/bin/bash
#Nombre del archivo: crear-inventario.sh

file="hosts"
read -p "Nombre del aula (ASIR1): " aula
aula=${aula:-ASIR1}

function elec {
read -p "Sobreescribir el archivo? (y/N/c): " sobre
sobre=${sobre:-N}

case $sobre in
	Y*|y*)
		aula2=$(echo "[$aula]" > $file)
		resul;;
	N*|n*)
	     	aula2=$(echo "[$aula]" >> $file)
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
$aula2
dev=$(ip route get 8.8.8.8 | grep "dev *" | cut -d" " -f 5)
nmap -p 22 --open -n $(nmcli dev show $dev | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5 >> $file
exit 0
}
elec
