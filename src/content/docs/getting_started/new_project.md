---
title: Nuevo proyecto
description: Cómo crear un proyecto Wollok
---

## Pre-requisitos

Es importante que ya tengas Wollok instalado y tu VSCode configurado como lo describimos en la [sección anterior](installation).

Asegurate que podés usar la _Wollok Command Line Interface_ (CLI) desde la consola, ya sea a patir del nombre del archivo que descargaste. Por ejemplo, probá desde una terminal:

```bash
wollok-ts-cli-macos-arm64 --version
```

O si renombraste el archivo a `wollok` queda:

```bash
wollok --version
```

Y deberías ver la versión de tu Wollok CLI.

## wollok init

La forma más rápida de crear un nuevo proyecto wollok es con el comando `wollok init` de CLI.
Para eso vamos a:

1. Crear una **carpeta nueva** con el *nombre del proyecto.

1. **Abrir una terminal** dentro de esa carpeta creada.

1. Usar el comando `init` de tu Wollok CLI:
```bash
wollok init
```

1. ¡Listo! 🌟

## Abrirlo en VSCode

Para abrir un proyecto Wollok en el VSCode podés

- Desde una terminal podés ejecutar el comando `code` pasando el directorio del proyecto Wollok. Por ejemplo, si tu terminal está sobre la carpeta del proyecto, podés hacer:
```bash
code .
```

- También lo podés hacer desde el menú del VSCode, en `Archivo -> Abrir carpeta...`.

> Esto también sirve para abrir cualquier proyecto, incluyendo los que te clones con git o te compartan por otro lado.