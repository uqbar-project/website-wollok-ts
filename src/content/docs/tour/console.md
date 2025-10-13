---
title: Consola
description: Consola Wollok en VSCode.
sidebar:
  order: 2
---


## Ejecutando archivos `.wlk` desde el REPL

Una de las primeras herramientas para trabajar es la consola [REPL](https://es.wikipedia.org/wiki/REPL) (nombre que surge del acrónimo **R**ead, **E**valuate, **P**rint, **L**oop), que permite la interacción inicial con el intérprete Wollok. 

Es una forma sencilla para comenzar a conocer cómo responden los objetos ante el envío de un mensaje.


Acceder a los comandos usando `Ctrl + Shift + P` (o desde el menú `View -> Commands Palette..`) + buscar `Wollok`.

Allí, elegir `Wollok: Start new REPL session`. 

<img width="975" alt="image" src="/assets/tour/console/startRepl.png">


El comando levanta una sesión, construye el proyecto y pone la consola al nivel del archivo que tenemos abierto para que podamos usar los objetos definidos en él directamente.

<video controls="" autoplay="" transition:persist>
  <source src="/assets/tour/console/replSession.mp4" type="video/mp4">
</video>

Podés enviar mensajes a objetos, crear referencias constantes o variables, probar cómo funcionan los números, las listas y otros objetos que vienen con Wollok, etc. 
Escribís la línea y al final presionás la tecla Enter. 
Con la flecha arriba te irán apareciendo los mensajes que enviaste anteriormente. 
También podés pegar código del portapapeles.

#### Diagrama dinámico 

Podés ver el diagrama dinámico en la pestaña [Diagrama dinámico](../dynamicdiagram).

#### Recargar un archivo modificado

Cuando modifiques un archivo .wlk, debés reiniciar la consola para recargar el archivo modificado y vuelva a ejecutarse.

Esto se hace con el comando `:r` (o `:reload`) y luego Enter. 

#### Recargar y volver a ejecutar la última sesión

Muchas veces nos pasa que al probar en la consola, necesitamos hacer un cambio sobre una definición. Eso nos obliga a 1. hacer el cambio y 2. reiniciar la consola para volver a ejecutar todos los comandos de la última sesión nuevamente, lo que puede ser un proceso tedioso. Por suerte podemos usar el comando `:rr` (o `:rerun`) y luego Enter para recargar el archivo modificado y volver a ejecutar la última sesión.

#### Terminar la sesión

Para terminar la sesión, debés usar el comando `:q` (o `:quit`) y luego Enter.

#### Menú de ayuda

Podés acceder al menú de ayuda con el comando `:h` (o `:help`) y luego Enter.

#### Importando archivos desde la consola

Wollok es una herramienta de exploración, eso incluye hacer pruebas sobre un archivo de definiciones de un proyecto y luego ir importando otros archivos usando `import` como si estuviera en un archivo. 
Esta opción solo funciona si ejecutás la consola con un archivo `.wlk` de tu proyecto.
