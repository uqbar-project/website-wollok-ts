---
title: Tests
description: Tests in Wollok.
sidebar:
    order: 3
---

## Automated Unit Testing ##
It's a tool that Wollok offers to test code in a much more practical, reliable, and professional way.


In the object-oriented programming paradigm... What do we want to test about an object? Mainly, its behavior: we want to send messages to the object and verify that what's expected happens.

### Unit ###
The type of testing we approach is qualified as "unit" because it's based on identifying significant code units and testing specific cases where they intervene.

### Automated ###
The fundamental characteristic of tests is that their execution and consequently their validation can be automated.


Tests are saved just like the solution code itself and when desired, they can all be executed at once, obtaining a report of the results of each one.

### Independent ###
Each test is conceived independently of any other.
The test execution logic assumes that each one runs from the system's initial state, meaning the environment resets between test and test, guaranteeing their total independence.

## Test Definition ##
Tests are defined in the same project as the solution itself, but in separate files with a representative name and .wtest extension (which shouldn't have the same name as your .wlk file).

At the beginning of our test file we must import the .wlk file we're going to test as follows:
```wollok
import pepita.*
```

### Assert ###
It's a self-defined object from the lib library, which understands the following messages:


**equals** : first goes the value expected to be returned by the message that goes second.
```wollok
test "pepita's initial energy" {
	assert.equals(100, pepita.energy())
}
```

**that**: the response is expected to be true.
```wollok
test "pepita starts being strong" {
	assert.that(pepita.isStrong())
}
```
**notThat**: the response is expected to be false.
```wollok
test "pepita flies many kilometers, and is no longer strong" {
	pepita.fly(60)
	assert.notThat(pepita.isStrong())
}
```
### Describe ###
We identify a set of tests with the reserved word **describe** and an expressive name with which we identify it. Curly braces { } are used to delimit the beginning and end, grouping all the tests that are part of it.
```wollok
describe "Pepita Tests" {
    test "pepita's initial energy" {
	    assert.equals(100, pepita.energy())
    }
    test "pepita starts being strong" {
	assert.that(pepita.isStrong())
    }
    test "pepita flies and loses energy" {
	pepita.fly(5)
	assert.equals(85, pepita.energy())
    }
}
```

### Tests ###
Within the previous describe, we can identify 2 types of tests: those that test messages with return values like `pepita's initial energy` and `pepita starts being strong`, or those that test methods with side effects like flying or eating - these first send those messages and then the message placed in the assert is a very simple one that just exhibits the caused effect.


## Test Execution ##

In the IDE, with a test file selected, click the run button (In the menu, Run > Run <Ctrl F11>).
If you have several test files defined, in addition to running them one by one as explained, you can run them all together (select the project, menu, Run > Run as > Run all Wollok project tests).



## Advanced Testing ##


### Describe Initialization ###
Within the describe, you can declare variables and constants. Just like when defined in objects or classes, they can be initialized with specific values, instantiating existing classes, or with the return value of any message. The scope of these variables and constants is all tests in the describe.
```wollok
describe "Pepita Tests" {
	// objects used in all tests
	const campana = new City(consumption = 60)
	const sanMartin = new City(consumption = 5)

	test "pepita starts with 100 energy units" {
		assert.equals(100, pepita.energy())
	}
}
```

### Initialize ###
When more complex initial configuration actions are required before each test, for which variable initialization is not enough, you can define an initialize method that expects no parameters.
```wollok
describe "Pepita Tests" {
	// objects used in all tests
	const campana = new City(consumption = 60)
	const sanMartin = new City(consumption = 5)

	// all tests start with pepita having
	// these two cities as favorites
	method initialize() {
		pepita.addCity(campana)
		pepita.addCity(sanMartin)
	}
}

```

### Auxiliary Methods ###
For certain actions that are repeated among some tests but are not common to all, you can define auxiliary methods, in the same way as methods of any object.
```wollok
describe "Pepita Tests" {
	// objects used in all tests
	const campana = new City(consumption = 60)
	const sanMartin = new City(consumption = 5)

	// there are tests that test different things from the same
	// situation, so one option is to define a method
	method takeCrazyTrip() {
	// since quilmes is only used here,
	// it's convenient not to define the reference in the describe
	// but to keep it within the test. Also, within the same
	// test we can see how quilmes is defined or what it represents,
	// which helps better understand what we're testing.
		const quilmes = new City(consumption = 1)
		pepita.fulfillWish()
		pepita.addCity(quilmes)
		pepita.fulfillWish()
		pepita.fulfillWish()
	}
}
```

## Error Testing ##

To test an error, the test must be written inside a code block that we pass to the assert object by sending the throwsExceptionLike message. We expect an exception to occur within that code.

Messages that assert understands:


**throwsException( block )**: is the most basic, in the test we expect an error (doesn't matter which one).
```wollok
test "when I want to withdraw an alphabetic value it throws an error" {
	assert.throwsException({ wallet.withdraw("A") })
}

```

**throwsExceptionWithMessage( errorMessage, block )**: we expect an error with a specific message (if the message doesn't match, the test fails).
```wollok
test "when I want to withdraw more money than I have it throws an error" {
	assert.throwsExceptionWithMessage(
		"Must withdraw less than 500", 
		{ wallet.withdraw(1000) }
	)
}
```

**throwsExceptionLike( exceptionExpected , block )**: is the most restrictive option, as the exception type and error message must match
``` wollok
test "when I want to withdraw a negative amount it throws an error" {
	assert.throwsExceptionLike(
   		new UserException( message = "The amount to withdraw must be positive" ), 
   		{ wallet.withdraw(-20) }
	)
}
```
