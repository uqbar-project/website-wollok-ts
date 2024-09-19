---
title: Problemas comunes
description: Problemas al intentar usar Wollok
---

Acá hay una lista de errores comunes detectados al instalar o ejecutar Wollok.


## La ejecución de scripts está deshabilitada en este sistema (Powershell)
Al querer ejecutar wollok por primera vez en Windows es posible que tire el siguiente error indicando que la consola no tiene _permisos de ejecución de scripts_.

<img width="646" alt="image" src="https://github.com/user-attachments/assets/d921aa75-c040-4a5f-8176-204ebe93a269">

Para solucionarlo es necesario _habilitar la ejecución de scripts_, para eso:

1. Abrí una consola (Powershell) en modo administrador: `Buscar la aplicación Powershell -> Click derecho -> Ejecutar como administrador`.

2. Cambiar la política a `Unrestricted` con el comando:
```bash
Set-ExecutionPolicy Unrestricted
```

3. Responder que sí a la confirmación del cambio: tipear `S` y enter.

4. Confirmar que el valor haya cambiado, debería responder `Unrestricted`:

```bash
Get-ExecutionPolicy 
```

5. Listo! Cerrá esa consola y volvé a ejecutar wollok desde una nueva consola o desde el VSCode.


## Problemas usando `nvm`

Si ya tenías otra versión de `node` además de [la necesaria para Wollok](../installation_recomended), y usás `nvm`, es posible que tengas _problemas al usar el VSCode_ si **la versión `default` no es la esperaba**.

Para eso podés verificar la versión por `default`:
```bash
nvm version default
```

Si _no_ es la recomendada, podés cambiar el alias:
```bash
nvm alias default 20
```

:::note[Nota]
La versión de `node` que usa Wollok puede cambiar. Guiarse por la que dice el [instructivo](../installation_recomended).
:::


## Problemas de un path con espacios
Si en la **ruta de carpetas del proyecto**, tanto dentro como fuera (la ruta base del proyecto), hay alguna con **espacios en el nombre** (u otros caracteres especiales) no vas a poder **ejecutar código** desde el VSCode.

Este problema ya está reportado [acá](https://github.com/uqbar-project/wollok-lsp-ide/issues/176).
Mientras tanto, te sugerimos **renombrar las carpetas** problemáticas para que no tengan espacios (u otros caracteres especiales).



## ¿Y ahora qué hago?

#### Si solucionaste el problema
Podés continuar haciendo el [Tour por las herramientas de VSCode](/tour/console) para ver cómo sacarle provecho a la herramienta.

#### Si no encontraste el problema o no está solucionado
Por favor reportalo como [issue en el repositorio de Github](https://github.com/uqbar-project/wollok-language/issues/new) así te damos una mano y le hacemos seguimiento.

Si tuviste problemas al instalar Wollok usando Node, te sugerimos probar con la [instalación alternativa](../installation_alternative) mientras encontramos una solución.

También podés ponerte en contacto con el equipo por medio del [Discord de Uqbar](https://discord.gg/ZstgCPKEaa).