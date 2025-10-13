---
title: Diagrama dinámico
description: Diagrama dinámico integrado al REPL
sidebar:
  order: 2
---

Al iniciar el REPL se despliega un diagrama dinámico, donde se ve el estado interno de los objetos y sus referencias.

![dynamic diagram (dark mode)](/assets/tour/dynamic-diagram/dynamicDiagramDark.png)

A medida que se envían los mensajes, se ve como se modifican los objetos en consecuencia.

:::caution[Configuración importante]
:::

El diagrama dinámico espera 1 segundo para levantar un servidor en el que se despliega el diagrama. Dependiendo de las capacidades de tu computadora, **puede que no sea tiempo suficiente**, en ese caso vas a ver una molesta pantalla en blanco.


En ese caso podés utilizar el ícono reload (↻) que va a permitir ver el diagrama normalmente.

Otra opción mucho menos molesta es que ajustes el valor en la configuración del IDE (`Ctrl + ,`) + buscar `Wollok LSP IDE`. Allí te aparece la opción `Milliseconds to Open Dynamic Diagram`: podés subirle el tiempo.

![settings](/assets/tour/dynamic-diagram/settings.png)

### Otras configuraciones

- **Open Internal Dynamic Diagram**: por defecto está activado y te abre un navegador interno al Visual Studio Code. Si lo desactivás te abre el navegador por defecto de tu sistema operativo.
- **Dynamic Diagram Dark Mode**: por defecto está activado, hace que el diagrama dinámico aparezca en modo oscuro. Si lo desactivás el diagrama aparecerá en modo claro por defecto.

### Opciones del diagrama

De arriba hacia abajo podés ver las siguientes opciones:

<img src="/assets/tour/dynamic-diagram/options.png" alt="options" width="160" />

- El botón `Organize` reorganiza los objetos en el diagrama dinámico tratando de facilitar la lectura (evitando colisiones de referencias)
- El toggle on/off `Modo claro/oscuro` permite cambiar el modo del diagrama dinámico para esta sesión particular (independientemente del modo por defecto que tiene configurado el IDE)
- El último toggle por defecto está desactivado, lo que reorienta los objetos del diagrama a medida que se van agregando. Si vos querés ubicar **manualmente** los objetos, te conviene activarlo, entonces solo se calculará la posición de un objeto en el momento de crearse y luego se mantendrá fijo. Esta configuración también mantiene una buena performance en especial cuando tenés muchos objetos (> 100).
