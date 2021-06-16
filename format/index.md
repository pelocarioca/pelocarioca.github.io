### Formatear y montar un disco, los comandos por defecto:

Primero se busca el disco a formatear:
`# fdisk -l`

Una vez encontrado se ejecuta:
```
# fdisk /dev/nombre-del-disco

-> p
-> *según proceda*
-> *según proceda*
-> *según proceda*
(si se requiere de más de una partición repetir los pasos anteriores)
-> w
-> q
```
El disco se encuentra particionado correctamente, se crea el sistema de archivos:

```
# mkfs /dev/nombre-de-la-partición


```
