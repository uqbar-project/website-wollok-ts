---
title: Wollok Game
description: Making games in Wollok.
sidebar:
    order: 5
---

## What is it?

Wollok-Game is a Wollok library used to create games. The idea it proposes is to have a kind of "board" where you can place objects from any Wollok program and it will automatically be displayed on the screen.
What follows describes how to use it and the functionalities it provides.

## The Game

The most important object for interacting with Wollok Game is the `game` object which requires importing the _game_ library from Wollok to use.

## How is it used?

### From the console ###

The most basic form is to import Wollok Game from the console (without an associated file) by doing

```wollok
wollok:example> import wollok.game.*
```

And then send messages one by one, as the console is habitually used.

```wollok
wollok:example> game.start()
👾 Game available at: http://localhost:3001
📁 Project path: [/Users/fernando/workspace/pdp/wollokPdp/GameInit]
🗂️ Assets folder: [assets]
🎨 Assets []
✓ true
```

On port 3001 of our machine the game engine starts. In a browser we can see the empty board by typing in the URL: `http://localhost:3001`

<img src="/assets/doc/game/tableroVacio.png" alt="Empty board" width="50%" height="auto" class="img-fluid z-depth-1"/>

### From console, with code file ###

A common way is to use a .wlk file and define the initial code there like any other valid wollok code, execute it and send messages through the console to perform desired actions.

File `example.wlk`

```wollok
import wollok.game.*

object pepita {
    var property position = game.at(2,2)
    
    method image() = "pepita.png"
}
```

_(For the complete translated version with all game features including visuals, collisions, keyboard events, etc., please refer to the full documentation)_

