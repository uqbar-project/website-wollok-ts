---
title: Collections
description: Collections in Wollok.
sidebar:
    order: 4
---

Wollok provides a literal for **List objects**, a collection that respects the order of entered elements.

The syntax is:

```wollok
[ element1, element2, ..., elementN ]
```

For example:

```wollok
const numbers = [2, 23, 25]

numbers.size() == 3   // true!
numbers.contains(23)  // true!

numbers.remove(23)
numbers.size() == 2   // true

numbers.clear()
numbers.size() == 0   // true
numbers.isEmpty()     // true
```

Since lists are objects (once again), the way to interact with lists is through messages.

To use more interesting messages, we need to know another very important object: [closures](#closures)! also known as **Code Blocks** or simply **Blocks**.

### Sets ###

Wollok also provides a literal for **Set objects**, a collection without duplicate elements or order.

The syntax is

```wollok
const numbers = #{2, 23, 25}
```

Note both the initial hash symbol and the curly braces enclosing the set elements.

### Dictionaries ###

Dictionaries (also known as _maps_ in other languages) are collections of key-value pairs, useful for quickly accessing elements by some known value.

```wollok
>>> const phones = new Dictionary()
>>> phones.put("ricky", "15-21...")
>>> phones.put("poly", "15-42...")
>>> phones.get("ricky")
```

You can study other interesting messages like keys(), values(), etc.

### Closures ###

A _closure_ is an object that represents a _portion of code_ that can be evaluated at any time, as many times as you want. They can also be assigned to references, passed as parameters, and returned as method results. For a more detailed explanation, see [this Wikipedia article](http://en.wikipedia.org/wiki/Closure_(computer_programming)).

Wollok supports closures through the use of literals.

Let's see an example:

```wollok
const helloWorld = { "helloWorld" }
const response = helloWorld.apply()		

response == "helloWorld"      // true
```

The first line defines a "helloWorld" closure that receives no parameters.
The second executes the closure by sending it the **apply()** message.

Here's another example with a closure that receives a parameter:

```wollok
const helloWorld = { to => "hello " + to }
const response = helloWorld.apply("world")
const response2 = helloWorld.apply("wollok")

response == "hello world"      // true
response2 == "hello wollok"    // true
```

So, the syntax for closures is:

```wollok
{param1, param2, ..., paramN => /* code */ }
```

An important fact about closures is that they not only access their parameters, but also any other reference in the context where they were defined. This makes them really powerful. Let's see a very simple example:

```wollok
var to = "world"
const helloWorld = { "hello " + to }
			
helloWorld.apply() == "hello world"       // true
		
to = "wollok"
helloWorld.apply() == "hello wollok"      // true
```

You can see that the closure accesses the "to" variable that is defined outside the closure's own context, within the program. If we change this reference, this effect propagates to the closure (as shown in the second call, the returned value is different).


### Closures and collections ###

Like most languages, Wollok provides a rich interface for operating with collections. This avoids writing tedious and repetitive code to filter, transform, or sum elements of a collection. Most of these messages receive closures as parameters.

For example, to perform certain logic on each of the elements, there's the **forEach** method:

```wollok
const numbers = [23, 2, 1]

var sum = 0
numbers.forEach({ n => sum = sum + n })
			
sum == 26      // true
```

If the only parameter being sent is a closure, you can omit the parentheses. The previous example can also be written

```wollok
numbers.forEach { n => sum = sum + n }
```

The **forEach** of a Dictionary works with a key-value pair.

```wollok
>>> const phones = new Dictionary()
>>> phones.put("ricky", "15-21...")
>>> phones.put("poly", "15-42...")
>>> phones.forEach { person, tel => console.println(person + " has " + tel) }
poly has 15-42...
ricky has 15-21...
```

To know if all elements meet a certain condition, there's the **all** message

```wollok
[3, 1].all { n => n > 0 } // true
```

**filter** returns a new collection with elements that meet a criterion.

```wollok
[3, 1, 0, 2].filter { n => n > 1 }  // [3, 2]
```

**map** returns a new collection with the result of the message sent to the elements of the original collection. The message is expressed within the _closure_.

```wollok
[10, 12].map { n => n / 2 } // [5,6]
```
