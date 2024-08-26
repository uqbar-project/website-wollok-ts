---
title: Validador
description: Validador de Wollok en VSCode.
---

## Detección de errores

La detección temprana de errores es una herramienta que va orientando al desarrollador a construir software con mayor robustez. 
En Wollok este rol lo cumple el validador que está integrado totalmente con el editor.

Detecta construcciones erróneas (constructores en objetos o tests, referencias inválidas,  envíos de mensajes incorrectos, entre otros), también chequea el uso o inicialización de variables y constantes como la mayoría de los entornos modernos. 
Pero Wollok lleva las validaciones a un nivel extra: evita malas prácticas como las construcciones `if (expresion) return true else false`, redefinir métodos que solo llamen a super, definir constructores que no inicialicen referencias constantes, definir una estructura de clases con referencias circulares, y muchas cosas más.

Y lo más importante, cada año se incorporan y se revisan esas validaciones de acuerdo a los trabajos prácticos que realizan los estudiantes y a la experiencia que vamos teniendo en las aulas. 
Sí, el código escrito retroalimenta al lenguaje.


![image](https://user-images.githubusercontent.com/4098184/226191755-fe48abb9-6bbd-49dd-b939-ae4c93ec5fbc.png)

Una muestra de cómo funciona el validador. 
Al posicionarnos con el mouse sobre el elemento subrayado, se expande la descripción de la advertencia (en amarillo) o el error (en rojo).
En la solapa Problemas tenemos un resumen de todos los _issues_ de cada uno de los proyectos.


### ¿Cómo visualizar la solapa Problemas?
Para activarla, presionar `Ctrl + Shift + M` o desde el menú `Ventana > Problemas`. 
Allí se agrupan los diferentes tipos de problema (error, advertencia, información).

### ¿Puedo ejecutar un programa con errores o advertencias?
La respuesta es **sí**: en el caso de las advertencias, se pasan por alto al ejecutar un programa, un test o 
la consola REPL. 
En el caso de errores, intentará ejecutar pero no se garantiza que llegue a un resultado, ya que el error puede ser que impida la normal ejecución del software que creaste.

