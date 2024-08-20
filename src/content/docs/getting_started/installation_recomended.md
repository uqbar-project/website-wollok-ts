---
title: Instalación Recomendada
description: Pasos para instalar Wollok con Node
---

## Wollok Command Line Interface: vía Node


### Windows

Instalar la versión 20 de Node desde [el link oficial](https://nodejs.org/en) haciendo click en la opción "Download Node.js (LTS)". Luego ejecutás el instalador y seleccionás Next dejando todas las opciones por defecto. En caso de dudas te recomendamos que veas [este tutorial](https://www.youtube.com/watch?v=29mihvA_zEA71)

Si la versión oficial no es la 20 en el momento en el que quieras descargarte el instalador, podés ir a [esta ventana](https://nodejs.org/en/download/package-manager) y allí seleccionar la última versión 20 de Node para tu sistema operativo. Una vez realizado este paso, te va a mostrar cómo es el mecanismo de instalación.

![Instalación](../../../assets/node_install.gif)

Verifiquemos que tenemos node instalado en nuestro sistema, desde cualquier carpeta abrimos la terminal que puede ser Powershell, la línea de comandos CMD o Git Bash:

```bash
node -v
# te debe devolver el número de versión 20.x.y
```

También deberíamos tener `npm` (el manejador de paquetes de Node) instalado:

```bash
npm -v
# te debe devolver el número de versión
```

Ahora sí, instalamos wollok haciendo

```bash
npm i -g wollok-ts-cli
```

Verificamos que tenemos instalado Wollok CLI. En la terminal escribimos:

```zsh
wollok --version
```

![Verificación wollok ts cli](../../../assets/wollok-ts-cli-path-win-3.gif)

:::note[Sobre la versión]
La versión que muestre será la última que te hayas descargado (no tiene que ser 0.2.2)
:::

### Linux

Instalar la versión 20 de Node desde [este link](https://nodejs.org/en/download/package-manager). La opción más simple es que uses **nvm** (Node Version Manager), un ejecutable que te permite manejar diferentes versiones de Node en tu máquina local. Seleccioná la última versión que aparezca para Node 20, el sistema operativo Linux y la variante nvm.

![Instalar node Mac](../../../assets/node_install_linux.gif)

Verifiquemos que tenemos node instalado en nuestro sistema, desde cualquier carpeta abrimos una terminal con `Ctrl` + `Alt` + `T`:

```bash
node -v
# te debe devolver el número de versión 20.x.y
```

También deberíamos tener `npm` (el manejador de paquetes de Node) instalado:

```bash
npm -v
# te debe devolver el número de versión
```

Ahora sí, instalamos wollok haciendo

```bash
npm i -g wollok-ts-cli
```

Verificamos que tenemos instalado Wollok CLI. En la terminal escribimos:

```zsh
wollok --version
```

![Verificación Linux wollok ts cli](../../../assets/wollok-ts-cli-linux-cmd-2.gif)

:::note[Sobre la versión]
La versión que muestre será la última que te hayas descargado (no tiene que ser 0.2.2)
:::

### Mac

Instalar la versión 20 de Node desde [este link](https://nodejs.org/en/download/package-manager). La opción más simple es que uses **brew** o **nvm** (Node Version Manager), un ejecutable que te permite manejar diferentes versiones de Node en tu máquina local. Seleccioná la última versión que aparezca para Node 20, el sistema operativo Linux y la variante nvm o brew.

![Instalar node Mac](../../../assets/node_install_mac.gif)

Verifiquemos que tenemos node instalado en nuestro sistema, desde cualquier carpeta abrimos una terminal con `⌘ (Cmd) + Espacio` o buscando `Terminal` en el Launchpad:

```bash
node -v
# te debe devolver el número de versión 20.x.y
```

También deberíamos tener `npm` (el manejador de paquetes de Node) instalado:

```bash
npm -v
# te debe devolver el número de versión
```

Ahora sí, instalamos wollok haciendo

```bash
npm i -g wollok-ts-cli
```

Verificamos que tenemos instalado Wollok CLI. En la terminal escribimos:

```zsh
wollok --version
```

:::note[Sobre la versión]
La versión que muestre será la última que te hayas descargado (no tiene que ser 0.2.2)
:::
