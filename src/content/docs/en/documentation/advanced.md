---
title: Advanced
description: Advanced Wollok concepts.
sidebar:
    order: 6
---


## Mixins ##

A mixin is a definition similar to a class in the sense that it defines both behavior and state, but the intention is to provide "abstract" functionality that can be **incorporated** into any class or object. In this way it's a more flexible option and favors reusability more than class-based inheritance.

Some characteristics of mixins:

* **cannot be instantiated** (only classes are instantiated)
* is "linearized" in the class hierarchy to avoid the [diamond problem](https://en.wikipedia.org/wiki/Multiple_inheritance#The_diamond_problem)
* **only supports inheritance from other mixins** (a mixin cannot inherit from a class, although a class can inherit from a superclass and optionally from many mixins)

```wollok
class Bird {}
mixin Flier inherits Bird {}                // INCORRECT: a mixin cannot inherit from a class
mixin Flier {}
mixin Glider inherits Flier {}              // CORRECT: a mixin can inherit from another mixin
```

Other technical details

* The mixing process is static
* you cannot decompose mixins from a class

### Simple Mixin ###

Here's an example of the simplest possible mixin, which provides a method

```wollok
mixin Flier {
  method fly() {
    console.println("I'm flying")
  }
}
```

Then it can be incorporated into a class

```wollok
class Bird inherits Flier {}
```

Then we can use it in a program / test / library

```wollok
const pepita = new Bird()
pepita.fly()  // prints "I'm flying"
```

_(For the complete translated version with all advanced features including multiple inheritance, method resolution, override, etc., please refer to the full documentation)_

