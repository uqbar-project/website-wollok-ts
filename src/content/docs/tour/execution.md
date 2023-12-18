---
title: Ejecutar Wollok
description: Ejecutar Wollok en VSCode.
sidebar:
  order: 2
---


## Ejecutando archivos `.wlk`


Listar los comandos usando `Ctrl + Shift + P` (o desde el menú `View -> Commands Palette..`) + buscar `Wollok`.

Aquí podemos ver los comandos de Wollok CLI que podemos usar desde el IDE.

<img width="975" alt="image" src="https://user-images.githubusercontent.com/4098184/204099843-8c81c40a-c9fc-4f46-b3ba-b00c5dab78ec.png">



### REPL

Una de las primeras herramientas para trabajar es la consola [REPL](https://es.wikipedia.org/wiki/REPL) (nombre que surge del acrónimo **R**ead, **E**valuate, **P**rint, **L**oop), que permite la interacción inicial entre el usuario y el intérprete Wollok. 

Si bien tiene algunos alcances limitados (como las opciones de autocompletado), es una forma de comenzar a conocer
cómo responden los objetos ante el envío de un mensaje.

El comando del IDE levanta una sesión, construye el proyecto y pone la consola al nivel del archivo que tenemos abierto para que podamos usar los objetos definidos en él más fácilmente.

<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226200946-20c11dc0-8ac1-40ee-baec-38048b4b5e99.mp4" 
    type="video/mp4">
</video>


Podés enviar mensajes a objetos, crear referencias constantes o variables, probar cómo funcionan los números, las fechas y otros objetos que vienen con Wollok, etc. 
Escribís la línea y al final presionás la tecla Enter. 
Con la flecha arriba te irán apareciendo los mensajes que enviaste anteriormente. 
También podés pegar código del portapapeles.


> Recordá que cuando modifiques un archivo .wlk, debés reiniciar la consola para que tome los cambios, vas a ver el aviso en la consola o bien en la barra de herramientas arriba a la derecha. 
> Las opciones en ese caso son: reiniciar desde cero tomando los nuevos cambios, o ejecutar automáticamente los mismos comandos que la última sesión.


#### Importando archivos desde la consola

Wollok es una herramienta de exploración, eso incluye hacer pruebas sobre un archivo de definiciones de un proyecto y luego ir importando otros archivos usando `import` como si estuviera en un archivo. 
Esta opción solo funciona si ejecutás la consola con un archivo `.wlk` de tu proyecto.



### Corriendo tests

Podemos correr los tests directamente desde el _codelens_ que ofrece el Editor.

#### Un solo test
<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226199882-8979f74c-4c33-4edf-96dc-cbbdea5079f0.mov" 
    type="video/mp4">
</video>

#### Un describe
<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226200606-cc3e438b-3751-4f90-a65a-ef7ff6033edf.mov" 
    type="video/mp4">
</video>

#### Un archivo
<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226200173-8e8890a0-8b67-422d-ba75-7396e5d621b7.mov" 
    type="video/mp4">
</video>




#### Todos los tests de un proyecto

Esto se puede hacer desde los comandos de Wollok (`Ctrl + Shift + P` + buscar `Wollok`).

#### Un archivo
<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226200188-b88b5a56-a190-4854-b684-026cc65e2180.mov" 
    type="video/mp4">
</video>


### Programas

De forma similar a los tests, podemos ejecutar Wollok programs desde el Editor, incluyendo Wollok Game 🕹️.

<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226204182-20441736-4873-4d19-b90c-7f901fe6f0ed.mp4" 
    type="video/mp4">
</video>


