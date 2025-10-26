---
title: Installation/Update
description: Steps to install Wollok
sidebar:
    order: 1
---

## Basic Components

We have these three components to install:

- Wollok-CLI (the language interpreter)
- IDE (Visual Studio Code)
- Extensions (developed for VSCode)

### Wollok CLI

The language interpreter is Wollok-CLI (Command Line Interface). It is the executable that runs Wollok programs. There are two ways to install it:

- [Via Node](/en/getting_started/installation_recomended) (recommended for personal computers)

:::note[Recommended]
This is the recommended way to install Wollok, as it is the simplest variant, has an agile update method, and includes optimizations that improve performance. If you encounter issues, you can download the latest _non-updated_ executable [here](https://github.com/uqbar-project/wollok-ts-cli/releases/tag/v0.3.0).
:::

<!-- - [Download executable](/en/getting_started/installation_alternative) (alternative for shared computers)

:::caution[Alternative]
This is recommended if conflicts arise with other Node installations, if difficulties occur with the recommended installation, or for occasional use.
:::
In both cases, consider the particularities of your operating system. -->

### IDE

The recommended Integrated Development Environment (IDE) is Visual Studio Code (VSCode), as it has extensions that make learning to program with Wollok more enjoyable. However, the source code is simply text and can be edited with any editor.

Install [VSCode](https://code.visualstudio.com/).

:::note[I already have VSCode installed, can I use the one I have?]
It is recommended that you download the latest version of VSCode: as of today, the minimum VSCode version required by the Wollok extension is 1.80 (June 2023) or later, but some features like REPL execution or tests may not appear in older versions.
:::

### Extensions

These instructions for installing and configuring Wollok extensions for VSC are independent of your machine's operating system.

1. **Open VSCode**

2. **Install the extensions** [`wollok-lsp-ide`](https://marketplace.visualstudio.com/items?itemName=uqbar.wollok-lsp-ide) and [`wollok-highlight`](https://marketplace.visualstudio.com/items?itemName=uqbar.wollok-highlight) available in the links or directly from the VSCode _Marketplace_. The order in which you install the extensions doesn't matter.

You can go to the Extensions tab, search for 'wollok' and install them as shown in this image:

![Download VSCode Wollok Extensions](/assets/installation/wollok-extensions.gif)

3. If everything went well, you should be able to see both extensions installed in your VSCode:

![Check extensions in Visual Studio Code](/assets/installation/wollok-extensions-check-2.gif)

<img width="449" alt="image" src="/assets/installation/extensions.png"/>

4. Now you need to **configure the extension** so it can use _Wollok-CLI_ to run programs.

- Go to the "settings" tab in VSCode: `Ctrl + ,` or from the menu: `Code -> Preferences -> Settings`. And search for `wollok`.

- The first setting that will appear is to indicate the _path_ where Wollok Command Line Interface (CLI) is located. For this, you need to enter in the field: `wollok`.

- There are also other configurations, such as selecting the language in which you want error messages to be displayed.

- At the end it should look something like this:

![Settings](/assets/installation/wollok-settings.png)

**Done!**

You should now be able to use VSCode with Wollok.

## Tutorial Videos (in Spanish)

### **Windows**

<iframe width="560" height="315" src="https://www.youtube.com/embed/kPxbjL7WUHc?si=lmdkD9oF2SxMpFeg" title="YouTube video player" frameborder="0" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

### **Linux**

<iframe width="560" height="315" src="https://www.youtube.com/embed/DCG-syufqhU?si=SBMGmBkEz6bS1-Wo" title="YouTube video player" frameborder="0" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Next Steps

What's next?

- You can see how to [create a Wollok project from scratch](/en/getting_started/new_project).
- You can download an [example](/en/material/examples) and try it out.
- If you already have a Wollok project in your VSCode, we recommend taking the [Tour of the tools we support](/en/tour/console) to get the most out of the IDE.
- If you have questions about the language, you can [go to the documentation](/en/documentation/introduction).

