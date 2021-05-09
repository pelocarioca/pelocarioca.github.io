## Instalación de MySQL por Chocolatey

### Introducción

Se va a proceder a instalar el gestor de bases de datos MySQL en un Windows Server 2019 (6/5/2021).

### Preparación de la instalación

1. Para instalar Chocolatey se ejecuta este código desde un terminal de PowerSHELL en modo administrador:  

`Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))`

![Instalación de Chocolatey](img/choco.png)

### Instalación

2. Una vez finalice, se ejecuta `choco install mysql` en el terminal para instalar MySQL:

![Instalación de MySQL](img/chocoinstallmysql.png)


3. Como esta instalación crea un usuario root sin contraseña, se le puede añadir una, desde el CMD, con:

` mysql -u root -p`

` ALTER USER root@localhost IDENTIFIED BY 'contraseña';`

` FLUSH PRIVILEGES;`


![Instalación de MySQL](img/chocoinstallmysql2.png)

4. Si se quiere cambiar el puerto, se accede a _C:\tools\mysql\current_ en el buscador de archivos:

![Instalación de MySQL](img/mysql1.png)

5. Se modifica el archivo _"my"_:

![Instalación de MySQL](img/mysql2.png)

El gestor de bases de datos MySQL ya estará correctamente instalado y configurado.
