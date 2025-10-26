---
title: Console
description: Wollok Console in VSCode.
sidebar:
  order: 2
---


## Running `.wlk` files from the REPL

One of the first tools to work with is the [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop) console (the name comes from the acronym **R**ead, **E**valuate, **P**rint, **L**oop), which allows initial interaction with the Wollok interpreter.

It's a simple way to start learning how objects respond to message sends.


Access the commands using `Ctrl + Shift + P` (or from the menu `View -> Commands Palette..`) + search for `Wollok`.

There, choose `Wollok: Start new REPL session`.

<img width="975" alt="image" src="/assets/tour/console/startRepl.png">


The command starts a session, builds the project, and sets the console at the level of the file we have open so we can use the objects defined in it directly.

<video controls="" autoplay="" transition:persist>
  <source src="/assets/tour/console/replSession.mp4" type="video/mp4">
</video>

You can send messages to objects, create constant or variable references, test how numbers, lists, and other objects that come with Wollok work, etc.
You write the line and press Enter at the end.
With the up arrow, the messages you sent previously will appear.
You can also paste code from the clipboard.

#### Dynamic Diagram

You can see the dynamic diagram in the [Dynamic Diagram](../dynamicdiagram) tab.

#### Reload a modified file

When you modify a .wlk file, you must restart the console to reload the modified file and have it execute again.

This is done with the `:r` (or `:reload`) command and then Enter.

#### Reload and re-run the last session

Often when testing in the console, we need to make a change to a definition. This forces us to 1. make the change and 2. restart the console to run all the commands from the last session again, which can be a tedious process. Fortunately, we can use the `:rr` (or `:rerun`) command and then Enter to reload the modified file and re-run the last session.

#### End the session

To end the session, you must use the `:q` (or `:quit`) command and then Enter.

#### Help menu

You can access the help menu with the `:h` (or `:help`) command and then Enter.

#### Importing files from the console

Wollok is an exploration tool, which includes testing on a project's definitions file and then importing other files using `import` as if you were in a file.
This option only works if you run the console with a `.wlk` file from your project.

