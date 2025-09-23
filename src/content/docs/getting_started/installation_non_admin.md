---
title: -> Wollok CLI sin Admin
description: Pasos para instalar Wollok con Node
sidebar:
    order: 10
---

## Wollok Command Line Interface: sin permisos de admin

Si te encontrás en una máquina sin permisos de administrador, por ejemplo por estar en una máquina de un laboratorio en tu universidad, o por una máquina del trabajo, te recomendamos que sigas estos pasos.

### Instalación en Windows

#### Habilitar ejecución de scripts

Abrir una ventana de Terminal Powershell 7 y ejecutar

```powershell
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

Confirmar que está correctamente configurado:

```powershell
Get-ExecutionPolicy
RemoteSigned (es la respuesta esperada)
```

#### Descargar Node como ejecutable

Confirmar primero que no tenemos Node instalado:

```powershell
node -v
node: The term 'node' is not recognized as a name of a cmdlet, function, script file, or executable program.
Check the spelling of the name, or if a path was included, verify that the path is correct and try again.
```

Ir a [la página de descarga de Node](https://nodejs.org/en/download), tendrá pre-seleccionada la versión LTS 22.19.0 de Node.

![Download Node zip](/assets/installation/node_zip_win.png)

Seleccionar la opción donde dice `Or get a prebuild Node.js for...` para Windows, y por último hacer click en `Standalone Binary (.zip)`.

Descomprimir y mover a una carpeta común `%USERPROFILE%\Node`. %USERPROFILE% es la carpeta raíz de tu usuario, que puede ser C:\Users\Usuario por ejemplo. Ojo, en la carpeta node debe estar los ejecutables, como `node.exe`. Si ves que dentro de la carpeta node hay otra carpeta `node-v22.19.0-win-x64` o similar, esto significa que tenés que apuntar los archivos de esa subcarpeta a la carpeta padre `Node`. La estructura de archivos debería quedarte así:

```bash
C:\
  + Users
    + Usuario (o el nombre de tu usuario)
      + Node
        + node.exe
        + npm.cmd
```

#### Hacer que Node se pueda ejecutar desde cualquier carpeta

Para eso hay que agregar la carpeta `Node` al PATH del usuario, ejecutamos desde una terminal de Powershell:

```powershell
$oldPath = [Environment]::GetEnvironmentVariable("Path", "User")
$newPath = "$oldPath;$env:USERPROFILE\node"
[Environment]::SetEnvironmentVariable("Path", $newPath, "User")
```

Verificar luego cómo quedó la variable PATH:

```powershell
[Environment]::GetEnvironmentVariable("Path", "User")
```

Debería haberte quedado en el PATH la carpeta `C:\Users\Usuario\Node`.

Cerrar la terminal y abrir otra terminal de Powershell. Ejecutar

```powershell
node -v
```

nos tiene que aparecer la versión de Node que instalamos, como `v22.19.0`.

#### Descargando npm

Probar si funciona npm como ejecutable:

```powershell
npm -v
```

Si recibís un mensaje de error (npm no existe como ejecutable o un error similar), entonces tenés que hacer lo siguiente:

```powershell
notepad $PROFILE
```

Eso abrirá un archivo de Notepad, nos preguntará si lo queremos crear, le decimos que sí. Dentro del archivo escribir una sola línea:

```powershell
Set-Alias npm npm.cmd
```

Luego guardamos (Alt + G) y por último salimos. Cerramos la sesión de Powershell y abrimos otra. Verificar que ahora sí nos responda

```powershell
npm -v
```

nos debe aparecer la versión, como `10.9.3`

#### Configurando la carpeta global de npm

Crear la carpeta `.npm-global`, siempre desde una terminal Powershell:

```bash
mkdir %USERPROFILE%\.npm-global
```

Si te da error este comando, significa que estás en otra terminal, como CMD. Cerrá dicha terminal y abrí una terminal Powershell. 

Configurar la carpeta donde vamos a ubicar los componentes globalmente instalados con npm:

```bash
npm config set prefix '%USERPROFILE%\.npm-global'
```

##### Descargando el CLI

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

TODO

Verificar que tenemos node instalado en nuestro sistema, desde cualquier carpeta abrimos una terminal con `Ctrl` + `Alt` + `T`:

```bash
node -v
# te debe devolver el número de versión 20.x.y
```

También deberíamos tener `npm` (el manejador de paquetes de Node) instalado:

```bash
npm -v
# te debe devolver el número de versión
```

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

### Instalación en Mac

TODO

Verificar que tenemos node instalado en nuestro sistema, desde cualquier carpeta abrimos una terminal con `⌘ (Cmd) + Espacio` o buscando `Terminal` en el Launchpad:

```bash
node -v
# te debe devolver el número de versión 20.x.y
```

También deberíamos tener `npm` (el manejador de paquetes de Node) instalado:

```bash
npm -v
# te debe devolver el número de versión
```

Ahora sí, instalar wollok mediante

```bash
npm i -g wollok-ts-cli
```

Verificar que tenemos instalado Wollok CLI. En la terminal escribir:

```zsh
wollok --version
```

:::note[Sobre la versión]
La versión que muestre será la última que te hayas descargado (no tiene que ser 0.2.2)
:::

