---
title: New Project
description: How to create a Wollok project
---

## ⏪ Prerequisites

It's important that you already have Wollok installed and your VSCode configured as described in the [previous section](/en/getting_started/installation).

### 🚀 New Common Project

Open a terminal window

- on Windows it can be CMD, Powershell, or Git Bash (recommended)
- on Linux by pressing `Ctrl` + `Alt` + `T` or typing `Terminal` from the main menu
- on Mac with the keys `⌘ (Cmd) + Space` or searching for `Terminal` in the Launchpad

and use the CLI `wollok init` command.

Navigate to the folder where you want to work.

```bash
wollok init --help
```

It will show you the options to create a project. For example:

```bash
wollok init --project bird-example    # or -p bird-example
```

will create the entire structure of a Wollok project.

### 🎮 New Game Project

If your intention is to create a project with Wollok Game, you need to use this command:

```bash
wollok init --project pepita-game --game  # or -p pepita-game -g
```

Done! 🌟

### 🔁 I want to migrate a Wollok Xtext project...

If you have a project made in Wollok Xtext and want to port it to Wollok TS, we offer [this migrator](https://github.com/fdodino/migrador-wollok-ts/blob/main/migrar-wollok-ts.sh) (follow the instructions shown in the [README](https://github.com/fdodino/migrador-wollok-ts/blob/main/README.md))


## 📄 Open it in VSCode

To open a Wollok project in VSCode

- you can run the `code` command passing the Wollok project directory. For example, if your terminal is in the project folder, you can do:

```bash
cd bird-example  # or whatever the project is called
code .
```

- you can also do it from the VSCode menu, in `File -> Open Folder...`

![Execute wollok ts cli](/assets/installation/newProject/vsc-open-project-1.gif)


:::note[Note]
This also works to open any project, including those you clone with git or share through other means.
:::

## What do I do now?

Now that you have a Wollok project, we invite you to

- Take the [Tour of VSCode tools](/en/tour/console).
- Or [go to the language documentation](/en/documentation/introduction).

