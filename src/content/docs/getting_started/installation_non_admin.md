---
title: -> Wollok CLI sin ser Admin
description: Pasos para instalar Wollok con Node sin permisos de administrador
sidebar:
    order: 10
---

## Wollok Command Line Interface: sin permisos de admin

Si te encontrás en una máquina sin permisos de administrador, por ejemplo por estar en una máquina de un laboratorio en tu universidad, o por una máquina del trabajo, te recomendamos que sigas estos pasos.

### Instalación en Windows

#### Habilitar ejecución de scripts

Abrir una ventana de Terminal Powershell y ejecutar

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Confirmar que está correctamente configurado:

```powershell
Get-ExecutionPolicy
RemoteSigned # es la respuesta esperada
```

#### Descargar Node como ejecutable

Confirmar primero que no tenemos Node instalado:

```powershell
node -v
node: The term 'node' is not recognized as a name of a cmdlet, function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Ir a [la página de descarga de Node](https://nodejs.org/en/download), tendrá pre-seleccionada la versión LTS de Node.

![Download Node zip](/assets/installation/non-admin/node_zip_win.png)

Elegir la opción donde dice `Or get a prebuild Node.js for...` para Windows, y por último hacer click en `Standalone Binary (.zip)`.

Descomprimir y mover a una carpeta común `$HOME\node`. $HOME es la carpeta raíz de tu usuario, que puede ser C:\Users\Usuario por ejemplo. Ojo, en la carpeta node debe estar los ejecutables, como `node.exe`. Si ves que dentro de la carpeta node hay otra carpeta `node-v22.19.0-win-x64` o similar, esto significa que tenés que apuntar los archivos de esa subcarpeta a la carpeta padre `node`. La estructura de archivos debería quedarte así:

```bash
C:\
  + Users
    + Usuario # el nombre de tu usuario
      + node
        + node.exe
        + npm.cmd
```

#### Hacer que Node se pueda ejecutar desde cualquier carpeta

Para eso hay que agregar la carpeta `node` al PATH del usuario, ejecutamos desde una terminal de Powershell:

```powershell
# Paso 1, testeamos si hay un profile
Test-Path $PROFILE
# si nos responde True, seguir al paso 2
# si nos responde False, ejecutar los siguientes comandos
New-Item -Path (Split-Path $PROFILE -Parent) -ItemType Directory -Force
New-Item -Path $PROFILE -Type File -Force

# Paso 2, editamos el profile
notepad $PROFILE
```

Al abrir el archivo, escribir las siguientes líneas:

```powershell
$nodePath = "$env:USERPROFILE\node"
if ($env:PATH -notlike "*$nodePath*") {
    $env:PATH += ";$nodePath"
}
Set-Alias npm npm.cmd
```

Guardamos el archivo y cerramos Notepad.

Verificar luego cómo quedó la variable PATH. Cerramos y abrimos una nueva terminal de Powershell:

```powershell
$env:PATH
```

Debería haberte quedado en el PATH la carpeta `C:\Users\Usuario\node`, donde `Usuario` es el nombre de tu usuario.

Ejecutar

```powershell
node -v
```

nos tiene que aparecer la versión de Node que instalamos, como `v22.19.0`.

#### Descargando npm

Desde la terminal ejecutar:

```powershell
Unblock-File -Path $HOME\node\npm.ps1
```

Verificar que funcione el programa que descarga paquetes de Node:

```powershell
npm -v
```

nos debe aparecer la versión.

#### Descargando el CLI

Ahora sí, instalar wollok mediante

```bash
npm i -g wollok-ts-cli
```

Verificar que tenemos instalado Wollok CLI. En la terminal escribir:

```zsh
wollok --version
```

![Verificación wollok ts cli](/assets/installation/recommended/wollok-ts-cli-path-win-3.gif)

:::note[Sobre la versión]
La versión que muestre será la última que te hayas descargado (no tiene que ser 0.2.2)
:::

### Instalación en Linux

#### Descargar Node y npm

Ir a la página oficial de descarga de [Node](https://nodejs.org/en/download/).

![Descargar Node](/assets/installation/non-admin/node-linux.png)

Elegir la opción por defecto (LTS), donde se instala nvm y npm y ejecutar en una terminal (Ctrl + Alt + T):

```bash
# Descargamos nvm (node version manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Restarteamos el shell
\. "$HOME/.nvm/nvm.sh"

# Descarga npm
nvm install 22

# Verificaciones: node
node -v # debería mostrar la versión de node instalada

# Verificaciones: npm
npm -v # debería mostrar la versión de node instalada
```

:::note[Sobre la versión]
Las versiones que te aparezcan pueden ser más nuevas, elegí la versión LTS (Long Term Support) de Node 22 ó 20.
:::

Ahora sí, instalar wollok mediante

```bash
npm i -g wollok-ts-cli
```

Verificar que tenemos instalado Wollok CLI. En la terminal escribir:

```bash
wollok --version
```

![Verificación Linux wollok ts cli](/assets/installation/recommended/wollok-ts-cli-linux-cmd-2.gif)

:::note[Sobre la versión]
La versión que muestre será la última que te hayas descargado (no tiene que ser 0.2.2)
:::

