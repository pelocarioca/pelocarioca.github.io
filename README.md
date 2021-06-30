# pelocarioca.github.io
Por Cassio de 1º de ASIR del IES Domingo Pérez Minik.

## Sobre el repositorio

Se trata de una guía de instalación y ejemplos de comandos ad hoc para Ansible, además incluye una serie de scripts de conveniencia que ayudan en la configuración de los inventarios de forma muy sencilla para el caso en el que se creó el repositorio. También contiene imágenes de las salidas de algunos de los comandos.

## Agradecimiento

La creación de la guía y sus contenidos no habría sido posible sin la ayuda de mi profesor de sistemas operativos Francisco Vargas Ruíz.

## TODO
(CONTRASEÑAS) Cambiar la contraseña del archivo de hosts de forma que se encuentre en un _vault_ de Ansible, para evitar que se pueda leer como texto plano.

(COPIAR-CLAVES) Crear un último script para copiar la clave pública desde un servidor externo, se puede intentar hacer montando una carpeta de la máquina que contenga la clave o mediante el comando curl a un servidor web que contenga la clave pública y añadiéndola al archivo ~/.ssh/authorized_keys en caso de que exista.

(IMÁGENES) Añadir las imágenes que faltan a la guía, no es del todo necesario pero por tener una guía más completa.

(SOLUCIONADO) Arreglar el problema de que la clave ssh generada no sirve para conectarse.
    - Puede ser un problema de generar las claves con sudo.
    - Debido a que se crean con sudo, profesor no cuenta con los permisos para utilizar la clave privada, se puede probar en a añadir una línea tipo `chown $usuario $rutakey` y
    darle los permisos 700 (si sigue sin funcionar 750)-> `chmod $rutakey 700`.
  SOLUCIÓN: Generar las claves como $usuario con `/bin/su -c "ssh-keygen..." $usuario`.

(SOLUCIONADO) Automatizar la selección de IPs, se puede tomar el comando:
```
dev=$(ip route get 8.8.8.8 | grep "dev *" | cut -d" " -f 5)
nmap -p 22 --open -n $(nmcli dev show $dev | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5
```
para guardar las salidas en un array, usando una sintaxis parecida a:
```
direcciones=(
  $(comando para recoger IP)
  )
```
## licencia

El repositorio y sus contenidos están licenciados bajo los términos de la GNU GENERAL PUBLIC LICENSE v3, teniendo más detalles acerca de la licencia en el archivo /LICENSE.
