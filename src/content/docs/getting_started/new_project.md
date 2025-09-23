---
title: Nuevo proyecto
description: Cómo crear un proyecto Wollok
---

## ⏪ Pre-requisitos

Es importante que ya tengas Wollok instalado y tu VSCode configurado como lo describimos en la [sección anterior](/getting_started/installation).

### 🚀 Nuevo proyecto común

Abrí una ventana terminal

- en Windows puede ser CMD, Powershell o Git Bash (recomendado)
- en Linux presionando `Ctrl` + `Alt` + `T` o escribiendo `Terminal` desde el menú principal
- en Mac con las teclas `⌘ (Cmd) + Espacio` o buscando `Terminal` en el Launchpad

y utilizá el comando `wollok init` de CLI.

Posicionate en la carpeta en la que querés trabajar.

```bash
wollok init --help
```

Te va a mostrar las opciones para crear un proyecto. Por ejemplo:

```bash
wollok init --project ejemplo-aves    # o -p ejemplo-aves
```

te va a crear toda la estructura de un proyecto Wollok.

### 🎮 Nuevo proyecto Game

Si tu intención es crear un proyecto con Wollok Game, tenés que utilizar este comando:

```bash
wollok init --project juego-pepita --game  # o -p juego-pepita -g
```

¡Listo! 🌟

### 🔁 Quiero migrar un proyecto Wollok Xtext...

Si tenés un proyecto hecho en Wollok Xtext y lo querés portar a Wollok TS te ofrecemos [este migrador](https://github.com/fdodino/migrador-wollok-ts/blob/main/migrar-wollok-ts.sh) (seguí las instrucciones que se muestran en el [README](https://github.com/fdodino/migrador-wollok-ts/blob/main/README.md))


## 📄 Abrirlo en VSCode

Para abrir un proyecto Wollok en el VSCode

- podés ejecutar el comando `code` pasando el directorio del proyecto Wollok. Por ejemplo, si tu terminal está sobre la carpeta del proyecto, podés hacer:

```bash
cd ejemplo-aves  # o como se llame el proyecto
code .
```

- también lo podés hacer desde el menú del VSCode, en `Archivo -> Abrir carpeta...`

![Execute wollok ts cli](/assets/installation/newProject/vsc-open-project-1.gif)


:::note[Nota]
Esto también sirve para abrir cualquier proyecto, incluyendo los que te clones con git o te compartan por otro lado.
:::

## ¿Y ahora qué hago?

Ahora que ya tenés un proyecto Wollok te invitamos a

- Hacer el [Tour por las herramientas de VSCode](/tour/console).
- O [ir a la documentación del lenguaje](/documentation/introduction).
