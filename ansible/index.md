# Instalación y uso básico de Ansible

## Introducción
Se va a documentar la instalación y uso básico de la herramienta de automatización [Ansible](https://www.ansible.com/), en esta guía se van a tratar los siguientes puntos:

1. Descarga de HelpSpot.
1. Instalación para Windows Server 2019.
  - Utilizando [Microsoft SQL Server 2008](SQLServer.md). (Opc. A)
  - Utilizando [MySQL](MySQL.md). (Opc. B)
2. Uso básico del producto.
  - Tickets.
  - Librería de autoservicio (Self Service Knowledge Base).
  - Análisis e informes.
  - Encuestas.
  - Creación de staff.

---
## Descarga de HelpSopt

1. En primer lugar se __accede__ al sitio web https://www.helpspot.com/free-help-desk-software, donde se __pulsará__ en el botón de _"Try it free"_.

![Descarga](img/descarga.png)

2. Esto llevará a una sección de registro, donde habrá que __crear__ una cuenta, en este caso se __selecciona__ la opción de _"DOWNLOAD TRIAL"_.

![Creación de una cuenta.](img/crearCuenta.PNG)

3. Al hacer esto se abrirá la página donde se puede descargar la licencia y el ejecutable, se __descargan__ y se guardan en el escritorio:

![Página de descarga.](img/paginaDescarga.PNG)

---
## Instalación del producto

1. Una vez se han descargado correctamente, se __ejecuta__ el instalador.

![Primer paso de la instalación.](img/instalador1.png)

2. Se __aceptan__ los términos de la licencia y se continúa.

![Aceptar los términos.](img/instalador2.png)

3. Se __selecciona__ el servidor _"Microsoft IIS Server"_ y se continúa.

![Seleccionar el tipo de servidor.](img/instalador3.png)

4. También se __selecciona__ el motor de bases de datos, se puede utilizar [Microsoft SQL Server](SQLServer.md) (Opción A) ó [MySQL Server](MySQL.md) (Opción B).

![Seleccionar el motor de bases de datos](img/instalador4.png)

5. En caso de escoger Microsoft SQL Server, pedirá una confirmación, se __pulsa__ _"Sí"_:

![Seleccionar el motor de bases de datos](img/ins5.png)

6. Se __selecciona__ la ubicación de la instalación, en este caso se instala en la ubicación por defecto:

![Seleccionar la ubicación de la instalación](img/ins6.png)

7. Se __introducen__ los datos de la cuenta de administración, en este caso son
- _Administrator Name: "Alumno"_
- _Administrator Email: "cassiopea_acebes_prado@iesdomingoperezminik.es"_
- _Company Name: "IES Domingo Pérez Minik"_:

![Datos de la cuenta](img/ins7.png)

8. Se __introduce__ una contraseña para la cuenta de administración, en este caso _"Onmula123"_:

![Datos de la cuenta](img/ins8.png)

9. Se __selecciona__ la zona horaria, en este caso _"Atlantic/Canary"_:

![Zona horaria](img/ins9.png)

10. Se __introducen__ el _"Customer ID"_ y el _"Licence File"_:

![Licencia](img/ins10.png)

11. Ahora se __introduce__ una dirección de correo para las respuestas a las notificaciones, en este caso se usa _"cassiopea_acebes_prado@iesdomingoperezminik.es"_:

![Reply to Email](img/ins11.png)

12. Se __introduce__ un nombre para el sitio web de IIS:

![Sitio Web](img/ins-a.png)

13. En el nombre de dominio, se deja la opción por defecto:

![Dominio](img/ins13.png)

14. Y se __selecciona__ el nombre de la página web que se va a usar, se deja por defecto:

![Web](img/ins14.png)
