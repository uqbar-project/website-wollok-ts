---
title: Dynamic Diagram
description: Dynamic diagram integrated with REPL
sidebar:
  order: 2
---

When starting the REPL, a dynamic diagram is displayed, showing the internal state of objects and their references.

![dynamic diagram (dark mode)](/assets/tour/dynamic-diagram/dynamicDiagramDark.png)

As messages are sent, you can see how the objects are modified accordingly.

:::caution[Important Configuration]
:::

The dynamic diagram waits 1 second to start a server on which the diagram is displayed. Depending on your computer's capabilities, **this may not be enough time**, in which case you'll see an annoying blank screen.


In that case, you can use the reload icon (↻) which will allow you to see the diagram normally.

Another much less annoying option is to adjust the value in the IDE settings (`Ctrl + ,`) + search for `Wollok LSP IDE`. There you'll find the option `Milliseconds to Open Dynamic Diagram`: you can increase the time.

![settings](/assets/tour/dynamic-diagram/settings.png)

### Other Settings

- **Open Internal Dynamic Diagram**: by default it's enabled and opens an internal browser within Visual Studio Code. If you disable it, it will open your operating system's default browser.
- **Dynamic Diagram Dark Mode**: by default it's enabled, making the dynamic diagram appear in dark mode. If you disable it, the diagram will appear in light mode by default.

### Diagram Options

From top to bottom you can see the following options:

<img src="/assets/tour/dynamic-diagram/options.png" alt="options" width="160" />

- The `Organize` button reorganizes the objects in the dynamic diagram to make them easier to read (avoiding reference collisions)
- The on/off `Light/dark mode` toggle allows you to change the diagram mode for this particular session (regardless of the default mode configured in the IDE)
- The last toggle is disabled by default, which reorients the diagram objects as they are added. If you want to **manually** position the objects, you should enable it, then the position of an object will only be calculated when it's created and will then remain fixed. This setting also maintains good performance especially when you have many objects (> 100).

