---
title: -> Wollok CLI via Node
description: Steps to install Wollok with Node
sidebar:
    order: 2
---

## Wollok Command Line Interface: via Node

### Installation on Windows

Install Node version 20 from [the official link](https://nodejs.org/en) by clicking on the "Download Node.js (LTS)" option. Then run the installer and select Next, leaving all options at default. If in doubt, we recommend watching [this tutorial](https://www.youtube.com/watch?v=29mihvA_zEA)

If version 20 is not the official version when you want to download the installer, you can go to [this page](https://nodejs.org/en/download/package-manager) and select the latest Node version 20 for your operating system. Once this step is complete, it will show you the installation mechanism.

![Installation](/assets/installation/recommended/node_install.gif)

Let's verify that we have node installed on our system. From any folder, open the terminal, which can be Powershell, CMD command line, or Git Bash:

```bash
node -v
# should return version number 20.x.y
```

We should also have `npm` (Node's package manager) installed:

```bash
npm -v
# should return the version number
```

Now we install wollok by running:

```bash
npm i -g wollok-ts-cli
```

Let's verify that we have Wollok CLI installed. In the terminal, type:

```zsh
wollok --version
```

![Verify wollok ts cli](/assets/installation/recommended/wollok-ts-cli-path-win-3.gif)

:::note[About the version]
The version shown will be the latest one you downloaded (it doesn't have to be 0.2.2)
:::

### Installation on Linux

Install Node version 20 from [this link](https://nodejs.org/en/download/package-manager). The simplest option is to use **nvm** (Node Version Manager), an executable that allows you to manage different Node versions on your local machine. Select the latest version that appears for Node 20, the Linux operating system, and the nvm variant.

![Install node Mac](/assets/installation/recommended/node_install_linux.gif)

Let's verify that we have node installed on our system. From any folder, open a terminal with `Ctrl` + `Alt` + `T`:

```bash
node -v
# should return version number 20.x.y
```

We should also have `npm` (Node's package manager) installed:

```bash
npm -v
# should return the version number
```

Now we install wollok by running:

```bash
npm i -g wollok-ts-cli
```

Let's verify that we have Wollok CLI installed. In the terminal, type:

```bash
wollok --version
```

![Verify Linux wollok ts cli](/assets/installation/recommended/wollok-ts-cli-linux-cmd-2.gif)

:::note[About the version]
The version shown will be the latest one you downloaded (it doesn't have to be 0.2.2)
:::

### Installation on Mac

Install Node version 20 from [this link](https://nodejs.org/en/download/package-manager). The simplest option is to use **brew** or **nvm** (Node Version Manager), an executable that allows you to manage different Node versions on your local machine. Select the latest version that appears for Node 20, the macOS operating system, and the nvm or brew variant.

![Install node Mac](/assets/installation/recommended/node_install_mac.gif)

Let's verify that we have node installed on our system. From any folder, open a terminal with `⌘ (Cmd) + Space` or by searching for `Terminal` in the Launchpad:

```bash
node -v
# should return version number 20.x.y
```

We should also have `npm` (Node's package manager) installed:

```bash
npm -v
# should return the version number
```

Now we install wollok by running:

```bash
npm i -g wollok-ts-cli
```

Let's verify that we have Wollok CLI installed. In the terminal, type:

```zsh
wollok --version
```

:::note[About the version]
The version shown will be the latest one you downloaded (it doesn't have to be 0.2.2)
:::

### Update (on any operating system)

If you have already installed Wollok CLI and want to update it, first check what version you have installed. In the terminal, type:

```bash
wollok --version
```

In a console, run the following command:

```bash
npm i -g wollok-ts-cli
```

Then verify if you have a new version number:

```bash
wollok --version
```

