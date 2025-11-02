---
title: Introduction to Wollok
description: Introduction to Wollok syntax.
sidebar:
    order: 1
---


## Wollok Files ##

Wollok currently has these file types, each representing a different concept:

* a **Wollok Program** (.wpgm)
* a **Wollok Module or Library** (.wlk)
* a **Wollok Test** (.wtest)

These will be explained in more detail in the following sections.

## Wollok Programs ##

A program is a piece of executable code consisting of a series of expressions that will be evaluated sequentially. It can be thought of as the main entry point (or _main_) of a program in other languages.

For example:

```wollok
program helloWorld {
   console.println("Hello world")
}
```

This program simply writes "Hello world" to the console. The following sections will explain how to understand each of the parts that make up the expression "console.println(...)". For now, you can think of it as a high-level instruction that is available in any program.

## Variable and Constant References ##

In Wollok there are two possible types of references: variables and constants.

A **variable** is a reference whose value can change at any time. What changes is not the object itself, but which object I'm pointing to with my reference.

```wollok
var age = 10
age = 11
age = age + 1
```

A **constant** is a reference that always points to the same object, so it's necessary to define the pointed object when initializing the reference. It's not a valid operation to try to change the reference to point to another object.

What is constant is not the pointed object (which can change its internal state) but the reference.

```wollok
const adultAge = 21

adultAge = 18  // THIS DOESN'T COMPILE!
```

## Comments ##

There are three types of comments

* single-line comments use double slash (//)
* multi-line comments start with /* and end with */
* "wollok-docs" comments start with /** and end with */. We'll see these later

Examples:

```wollok
const adultAge = 21   // single-line comment

/*
 multi-line
 comment
 */
adultAge = 18
```

## Basic Objects ##

There are basic objects that come with the Wollok distribution.

### Numbers ###

Numbers understand a wide variety of messages, such as mathematical operations for adding, subtracting, etc. They are immutable objects, which means that

* their internal state doesn't change
* for example, the sum of 1 + 2 results in a new number representing 3.

```wollok
const a = 1
var b = a + 10  // addition
b = b - 1       // subtraction
b = b * 2       // multiplication
b = b / 2       // division
b = b % 2       // remainder
b = b ** 3      // cubed
5.between(2, 7) // ask if 5 is between 2 and 7 ==> yes
3.min(6)        // the smaller number between 3 and 6 ==> 3
3.max(6)        // the larger number between 3 and 6 ==> 6
(3.1416).truncate(0)  // the integer part of 3.1416 ==> 3 -- (3.1416).truncate(2) = 3.14
(3.1416).roundUp(0)   // the first integer greater than 3.1416 ==> 4  -- (3.1416).roundUp(2) = 3.15
```

Additionally, Wollok supports **suffix operators** as well as **the += operation** among other variants, which are _shortcuts_ for other expressions.

```wollok
b += 2          // b = b + 2
b -= 1          // b = b - 1
b *= 3          // b = b * 3
b %= 2          // b = b % 2
b /= 2          // b = b / 2
```

### Booleans ###

There are two boolean objects represented by the literals **true** and **false**. They are immutable objects, the expression ```true || false``` returns a new true object.

```wollok
const fact = true and true
const isTrue = true
const isFalse = false

const willBeFalse = isTrue and isFalse

const willBeTrue = isTrue or isFalse

const willBeTrue = not false
```

For those who are used to operators with symbols, you can use this alternative syntax:

* **and**: ```a && b```
* **or**: ```a || b```
* **not**: ```!a```

All [equality operations](#comparing-equal-objects) and [comparison](#comparing-objects-in-general) operations return boolean objects.

### Strings ###

Character strings are delimited with single or double quotes.

```js
const aString = "hello"
const anotherString = 'world'
```

They are also immutable objects (when concatenating "hello" and "world" we get a new String "helloworld").

```wollok
const helloWorld = aString + " " + anotherString + "!"   // "hello world!"
```

### Dates ###

A date is an immutable object that represents a day, month, and year (without hours or minutes). They are created in two possible ways:

```wollok
const today = new Date()  
        // takes today's date
const someDay = new Date(day = 30, month = 6, year = 1973)  
        // entered in day, month, and year format
```

Some operations we can do with dates are:

```wollok
const today = new Date()
today.plusYears(1)    // new date one year later
today.plusMonths(2)   // new date 2 months later
today.plusDays(20)    // new date 20 days later
today.isLeapYear()    // if the year is a leap year
today.dayOfWeek()     // the day of the week: monday, tuesday, etc.
today.month()         // the month number
today.day()           // the day number
today.year()          // the year
const yesterday = today.minusDays(1)  // subtract one day to get yesterday
yesterday < today     // date comparison => true
const aMonthAgo = today.minusMonths(1)  
yesterday.between(aMonthAgo, today)  // yesterday is between a month ago and today => true
yesterday - today     // difference in days between yesterday and today (absolute) => 1
```

### Comparing Equal Objects ###

The following expressions that compare if two objects are equal result in boolean values:

```wollok 
const one = 1
const two = 2

const isFalse = (one == two)

const isTrue = one == 1

const isTrue = (one != two)
```

* == tells us when two objects **are equal**
* != tells us when two objects **are not equal**

After introducing objects and classes, we'll review this concept.

### Comparing Objects in General ###

We also have other expressions that allow us to compare objects (generally numbers, but also Strings and dates)

```wollok
const isTrue = 23 < 24      // less than
const isTrue = 23 <= 24     // less than or equal to
const isTrue = 24 > 10      // greater than
const isTrue = 24 >= 10     // greater than or equal to
```

