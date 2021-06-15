# Instalación y uso básico de Ansible

## Introducción
Se va a documentar la instalación y uso básico de la herramienta de automatización [Ansible](https://www.ansible.com/) para un Ubuntu Server 20.4, en esta guía se van a tratar los siguientes puntos:

1. Instalación de Ansible.
    - Requisitos.
    - Instalación por pip.
    - Instalación en Ubuntu.
    - Instalación por Docker.
2. Configuración de los hosts.
    - Conexión a los hosts.
    - Configuración de un Inventario.
4. Comandos Ad hoc.
5. Apartado comandos y Scripts necesarios o útiles.

---
## Instalación de Ansible

### Requisitos

Para el nodo de control se va a requerir Python 2, v2.7, o Python 3, +v3.5, un dato a tener en cuenta es que Windows no tiene soporte como nodo de control.

Los nodos que se están administrando, se va a necesitar la posibilidad de conexión por SSH y por SFTP, aunque en caso de no estar disponible se puede utilizar SCP.

### Instalación por pip

1. Por este método, se va a instalar ansible para un usuario "alumno", en caso de no tener instalado pip, se ejecuta en un terminal:

`$ curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python3 get-pip.py --user`

Para instalar Ansible ejecuta el siguiente comando:

`$ python3 -m pip install --user ansible`

![Instalación por pip](img/ins1.png)

En caso de fallar este comando, apareciendo la siguiente línea en su salida: _"Building wheel for ansible (setup.py) (...) error"_, se debe ejecutar:

`$ python3 -m pip install --user wheel`

Si el comando de instalación se ejecuta correctamente, Ansible ya debería estar correctamente instalado en el servidor.

### Instalación en Ubuntu:

1. Desde un terminal se ejecuta el comando:

`$ sudo apt update`

![Instalación en Ubuntu](img/ins2.png)

`$ sudo apt install software-properties-common`

![Instalación en Ubuntu](img/ins4.png)

`$ sudo add-apt-repository --yes --update ppa:ansible/ansible`

![Instalación en Ubuntu](img/ins5.png)

`$ sudo apt install ansible`

![Instalación en Ubuntu](img/ins6.png)

Para comprobar que se ha instalado correctamente se ejecuta:

`$ ansible all -m ping`

![Instalación en Ubuntu](img/ins3.png)

Esto indica que no hay __hosts__ en el inventario, únicamente localhost, pero confirma que se ha instalado correctamente.

### Instalación por Docker.

En una máquina con [Docker](https://www.docker.com/) instalado se ejecuta, desde un terminal, el comando:

`$ docker run ansible`

Cuando finalice se, se puede comprobar que se está ejecutando con:

`$ docker ps`

Debería aparecer el contenedor de Ansible en funcionamiento.

## Configuración de los hosts.

### Conexión a los hosts.

Para conectar el nodo de control a los hosts que se van a administrar se suele utilizar una conexión por SSH, de forma que los últimos deben tener instalada la clave pública del nodo de control y el servicio OpenSSH-server. Además deben tener el puerto 22 habilitado en su entrada al menos para la dirección del servidor.

Para crear el par de claves pública y privada se ejecuta el comando:

`$ ssh-keygen -f 'Ruta de la clave/ansible-host-key' -t ecdsa -b 521`

Y para copiar la clave en los clientes se puede utilizar:

`$ ssh-copy-id -i 'Ruta de la clave/ansible-host-key' usuario@host`

O añadirla manualmente desde el cliente, el cual tiene la clave en el archivo ~/ansible-host-key.pub:

`$ cat 'Ruta de la clave/ansible-host-key.pub' >> '~/.ssh/authorized_keys'`

O ejecutar este script, requiere de tener instalado en el servidor el paquete sshpass, en caso de no tenerlo se puede instalar con `$ sudo apt install -y sshpass`.

```#!/bin/bash
#!/bin/bash
#Nombre del archivo: copiar-claves-servidor.sh

direcciones=("10.1.1.43" "10.1.1.45" "10.1.1.46" "10.1.1.47")
ruta=~/.ssh/ansible-host-key.pub
usuario=profesor
contrasena=roseforp

for i in "${direcciones[@]}"
do
sshpass -p $contrasena ssh-copy-id -i $ruta -o StrictHostKeyChecking=no ${usuario}@$i
done
```

[Enlace de descarga del script.](./copiar-claves-servidor.sh)

### Configuración de un Inventario.

Ahora se va a configurar un inventario de las máquinas clientes, para ello se modifica el archivo **/etc/ansible/hosts** al que se le añade la siguiente configuración:

```Inventario
[1ASIR]
PC1   ansible_host=10.1.1.
PC2   ansible_host=10.1.1.
PC3   ansible_host=10.1.1.
PC4   ansible_host=10.1.1.

[1ASIR:vars]
ansible_user=Profesor
ansible_password=roseforp
```

![]()

Se guarda el archivo y se reinicia el servicio con el comando:

`$ systemctl restart ansible`

![]()


## Comandos Ad hoc.

Una vez se han inventariado los clientes y se ha copiado la clave pública en ellos, se puede comprobar la conexión a ellos con:

`$ ansible all -m ping`

![]()

[Documentación sobre comandos Ad Hoc.](https://docs.ansible.com/ansible/latest/user_guide/intro_adhoc.html#managing-packages)

La sintaxis básica de un comando Ad hoc es:

## Apartado comandos y Scripts necesarios o útiles.

Obtención de IP del propio equipo:

`$ nmcli dev show eno1 | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2`

Obtención de las direcciones física e IPv4 de los equipos de la red:

`$ nmap -sP -n $(nmcli dev show eno1 | grep "^IP4\.ADDRESS.*:" | tr -s " " | cut -d" " -f2) | grep "^Nmap scan" | cut -d" " -f5`
