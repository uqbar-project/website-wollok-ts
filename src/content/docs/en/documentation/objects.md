---
title: Objects
description: Wollok Objects.
sidebar:
    order: 2
---

## User Objects ##

In addition to the predefined objects we've recently seen, any object-oriented language must allow developers to create their own objects.

This can be done in two slightly different ways:

* Self-defined objects
* Anonymous objects

### Self-defined objects ###

Self-defined objects allow you to make _custom_ definitions with particular state and behavior. Other names you might find in different literature are _Named Objects_, "Well-Known Objects" (wko) or "singleton".

To define an object we use this construction:

```wollok
object myObject {
    // here goes the code for myObject
}

console.println(myObject)
```

From here we can access the "myObject" reference anywhere in the program.

### Anonymous objects ###

Another option is to use literal objects without explicitly giving them a name. This allows using them in the moment without using a reference or assigning them to a variable with more limited scope than global.

```wollok
console.println( object { /* code here */ }
)
```

The created object serves as a didactic example, as it's an empty object. In the console you'll only see

```
anObject{}
```

### Methods ###

Inside an object's braces, you can define its behavior by implementing methods. For example, we'll represent a bird:

```wollok
object pepita{
    method areYouHappy() {
        return true 
    }
    method greet(name) {
        return "hello " + name
    }

}

console.println(pepita.areYouHappy())    // true
console.println(pepita.greet("pepona"))  // "hello pepona"
```

Methods are defined using the **method** keyword. They can receive from 0 to n parameters and optionally return a value. Parameter types don't need to be defined. If it has any, each parameter is a reference that will be present in the method's evaluation context.

If the method returns a value, it's mandatory to write a **return** statement, except for [simple return methods](#simple-return-method) explained in the next section.

#### Simple Return Method ####

There's a _shortcut_ for defining simple one-line methods that only return values.

```wollok
object pepita {
    method isHappy() = true
    method greet(name) = "hello " + name
}
```

Readers will note that it's not necessary to write return, nor the braces that enclose the method body. The braces are replaced by the = symbol, which indicates that evaluating the right side of the method will be the returned value.


### Attributes ###

So far pepita doesn't do very interesting things, it always returns the same thing or only depends on the parameters it receives in messages. So we'll add "state" to the object, through attributes, also called instance variables, in which it will store values, remember information and ultimately reference other objects. Some methods will make the object's state change, assigning new values to the attributes. In turn, the object's state itself will influence the response of other methods.

```wollok
object pepita {
    var energy = 100
    method fly(meters) {
        energy = energy - 2 + meters
    }
    method eat(grams) {
        energy = energy + grams
    }
    method isHappy() {
        return energy > 50
    }
}

pepita.fly(23)
pepita.eat(10)
pepita.isHappy()
```

The **energy** attribute initially has a value of 100. Each time pepita is sent the **fly()** or **eat()** message, the value that energy references changes, and when asked about **isHappy()**, the answer depends on the current energy value.

Instance references are declared in an object, just before the first method. [As we've seen](#variable-and-constant-references), references can be **var** or **const**.

**All instance references are only visible within the same object**, they can be accessed from any of its methods.

These expressions **are not valid**.

```wollok
pepita.energy 
pepita.energy = 200
pepita.energy() // would be valid if a method called energy() were defined
```

### Messages ###

One of the most important concepts in object-oriented programming is **messages**. In Wollok, (almost) everything you do is send messages to objects.

When sending a message to an object, the method definition is executed.

To send a message, the syntax is:

```wollok
object.message(param1, param2, ...)
```

These variants **are not valid**:

```wollok
message(param1, param2)   // missing receiver object
object.message            // missing parentheses
```

### Self ###

What happens when I'm in an object and want to send a message to myself to take advantage of an existing method?

In that case we use **self**, which is a reference that points to the object where we're writing the code.

```wollok
object pepita {
    var energy = 100
    method fly(meters) {
        energy = energy - 2 + meters
    }
    method eat(grams) {
        energy = energy + grams
    }
    method isHappy() {
        return energy > 50
    }

    // NEW METHOD
    method flyAndEat(metersToFly, gramsToEat) {
        self.fly(metersToFly)
        self.eat(gramsToEat)
    }
}

pepita.flyAndEat(23, 10)
```

### Polymorphism  ###

**Polymorphism** is the ability of an object to be interchangeable with another, without a third party using them being affected.

Wollok shares some characteristics with dynamically typed languages, as it has a [Pluggable Type System](http://bracha.org/pluggableTypesPosition.pdf). This means that if two objects understand the same messages, then we don't need anything else for a third party to use them polymorphically.

For example, we'll change pepita's way of eating. Instead of directly telling it how many grams to eat, we indicate what thing to eat, so that the amount of grams will depend on the food passed as a parameter.

```wollok
object pepita {
    var energy = 100
    method fly(meters) {
        energy = energy - 2 + meters
    }
    method eat(food) {
        energy = energy + food.energy() // a "food" is something that provides "energy"
    }
    method isHappy() {
        return energy > 50
    }
}
```

The **eat()** method can receive in the **food** parameter any object that understands the **energy()** message and returns a number (the amount of energy it provides).

For example, you can have different objects that represent things pepita can eat:

```wollok
object birdseed{
    var weight = 2
    method energy() { return weight * 5 } 
}

object rice {
    method energy() { return 2 }
}

pepita.eat(birdseed)
pepita.eat(rice)
pepita.eat(object{method energy() = 1000}) // Can also be an anonymous object
```

Here both **birdseed** and **rice** are polymorphic with respect to **pepita** in the **eat()** message.

### If ###

The **if** expression allows evaluating a boolean condition and performing different actions for the true and false cases respectively.

For example:

```wollok
if (self.isRaining()) {
    self.goHomeIn(self.car())
}
else 
    self.goHomeIn(self.bike())
```

In Wollok, "if" is not a statement (that controls flow) but rather an expression. This means it returns a value, which allows changing the example to this other form:

```wollok
const transport = 
   if (self.isRaining()) self.car() else self.bike()

self.goHomeIn(transport)
```

### Properties ###

A convenience that Wollok offers is defining attributes as properties, which automatically assumes the existence of accessor methods, without having to make them explicit in the code (a task that is usually repetitive to write and annoying to read). They're declared with the **property** word before the reference name. In the case of variables, it includes **getters** and **setters**; in the case of constants, only the **getters**.


The following example...

```wollok
object pepita {
    var energy = 100
    const performance = 5

    method energy() {
        return energy
    }
    method energy(newEnergy){
        energy = newEnergy
    }
    method performance() {
        return performance
    }
}
```
... without losing functionality, can be rewritten like this:

```wollok
object pepita {
    var property energy = 100
    const property performance = 5
} 
```

In both cases it's equivalent to query:

```wollok
pepita.energy() 
pepita.performance()
```
