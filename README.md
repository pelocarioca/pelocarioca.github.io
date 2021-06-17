# pelocarioca.github.io

## TODO
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
