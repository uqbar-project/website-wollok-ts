---
title: Consola Wollok
description: Console Wollok en VSCode.
sidebar:
  order: 2
---


## Ejecutando archivos `.wlk` desde el REPL

Una de las primeras herramientas para trabajar es la consola [REPL](https://es.wikipedia.org/wiki/REPL) (nombre que surge del acrónimo **R**ead, **E**valuate, **P**rint, **L**oop), que permite la interacción inicial con el intérprete Wollok. 

Es una forma sencilla para comenzar a conocer cómo responden los objetos ante el envío de un mensaje.


Acceder a los comandos usando `Ctrl + Shift + P` (o desde el menú `View -> Commands Palette..`) + buscar `Wollok`.

Allí, elegir `Wollok: Start new REPL session`. 

<img width="975" alt="image" src="https://user-images.githubusercontent.com/4098184/204099843-8c81c40a-c9fc-4f46-b3ba-b00c5dab78ec.png">


El comando levanta una sesión, construye el proyecto y pone la consola al nivel del archivo que tenemos abierto para que podamos usar los objetos definidos en él directamente.

<video controls="" autoplay="" transition:persist>
  <source 
    src="https://user-images.githubusercontent.com/4098184/226200946-20c11dc0-8ac1-40ee-baec-38048b4b5e99.mp4" 
    type="video/mp4">
</video>

Podés enviar mensajes a objetos, crear referencias constantes o variables, probar cómo funcionan los números, las listas y otros objetos que vienen con Wollok, etc. 
Escribís la línea y al final presionás la tecla Enter. 
Con la flecha arriba te irán apareciendo los mensajes que enviaste anteriormente. 
También podés pegar código del portapapeles.

#### Diagrama dinámico 

Al iniciar el REPL se despliega un diagrama dinámico, donde se ve el estado interno de los objetos y sus referencias.

A medida que se envían los mensajes, se ve como van quedando modificados los objetos en consecuencia. 

#### Recargar un archivo modificado

Cuando modifiques un archivo .wlk, debés reiniciar la consola para recargar el arhivo modificado y vuelva a ejecutarse.

Esto se hace con el comando `:r` y luego Enter. 


#### Importando archivos desde la consola

Wollok es una herramienta de exploración, eso incluye hacer pruebas sobre un archivo de definiciones de un proyecto y luego ir importando otros archivos usando `import` como si estuviera en un archivo. 
Esta opción solo funciona si ejecutás la consola con un archivo `.wlk` de tu proyecto.
