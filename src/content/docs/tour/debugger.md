---
title: Debugger
description: Debugger de7Wollok en VSCode.
sidebar:
  order: 7
---

El debugger de Wollok permite detener la ejecución de un programa y avanzar paso a paso para entender qué está ocurriendo.

<video controls="" autoplay="" transition:persist>
  <source src="/assets/tour/debugger/debugger.mp4" type="video/mp4">
</video>

## Breakpoints

Los breakpoints permiten detener la ejecución del programa en una línea determinada.

Para agregar uno, hacé click sobre el margen izquierdo de la línea que quieras detener.

![Breakpoint en el editor de Wollok](/assets/tour/debugger/breakpoint.png)

Al ejecutar el programa, Wollok se detendrá al llegar al breakpoint.

## Controlar la ejecución

Cuando el programa está detenido, podés utilizar los controles del debugger para avanzar en la ejecución.

- **Continue**: continúa la ejecución hasta el próximo breakpoint.
- **Step Over**: avanza a la siguiente instrucción.
- **Step Into**: entra en el método que se está ejecutando.
- **Step Out**: sale del método actual y continúa desde el lugar donde fue llamado.

![Controles del debugger](/assets/tour/debugger/debug-controls.png)

## Consultar variables y llamadas

Mientras el programa está detenido, podés consultar el estado actual de la ejecución.

### Variables

En la sección **Variables** podés ver los valores de las variables disponibles en ese momento.

### Call Stack

La sección **Call Stack** muestra las llamadas que llevaron hasta el punto actual de ejecución.

![Variables y Call Stack](/assets/tour/debugger/debug-panel.png)

## Debuggear tests

También podés utilizar el debugger mientras ejecutás tests de Wollok para detenerte en el código y revisar qué está sucediendo.

<video controls="" transition:persist>
  <source src="/assets/tour/debugger/debugger-test.mp4" type="video/mp4">
</video>
