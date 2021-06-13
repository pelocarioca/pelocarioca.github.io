### Arreglar el problema E: No se pudo bloquear /var/lib/dpkg/lock-frontend - open (11: Recurso no disponible temporalmente)

Sencillamente se mata al proceso que esté bloqueado:

`$ sudo fuser -vki /var/lib/dpkg/lock`

Se borra el archivo:

`$ sudo rm -f /var/lib/dpkg/lock`

Se reparan los paquetes:

`$ sudo dpkg --configure -a`

Y se arregla cualquier problema:

`$ sudo apt-get autoremove`

¡Cuando lo pida el prompt se pulsa __S__ y arreglado!
