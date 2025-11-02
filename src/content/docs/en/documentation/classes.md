---
title: Classes
description: Classes in Wollok.
sidebar:
    order: 4
---


Classes share some characteristics with literal objects: they define instance variables and methods. But they're not expressions (they can't be assigned to variables), they're **definitions**.

Let's see an example:

```wollok
class Bird {
    var energy = 0

    method fly(meters) {
        energy = energy - (2 + meters)
    }
    method eat(food) {
        energy = energy + food.energy()
    }
    method energy() {
        return energy
    }
}
```

### Instantiation ###

To create a Bird we instantiate an object of that class with the reserved word **new**, which returns an object of the Bird class:

```wollok
const pepita = new Bird()
pepita.fly(23)
```

When creating an object, you can give initial values to each of its attributes, so that the obtained object is complete and consistent. Between the **( )** you indicate the identifier of each reference and its initial value. Since the name of each attribute is indicated, it's not necessary to maintain a particular order when sending parameters.

```wollok
const pepita = new Bird(energy = 100)
```

This makes pepita initialized with 100 energy.

For class references that have a default value set, it's optional to send the value as a parameter, but for references without initialization in the class definition, it's mandatory to send the initial value as a parameter.

_(For the complete translated version with all class features including inheritance, constructors, polymorphism, etc., please refer to the full documentation)_

