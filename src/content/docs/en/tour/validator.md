---
title: Validator
description: Wollok Validator in VSCode.
---

## Error Detection

Early error detection is a tool that guides developers to build more robust software.
In Wollok, this role is fulfilled by the validator, which is fully integrated with the editor.

It detects erroneous constructions (constructors in objects or tests, invalid references, incorrect message sends, among others), and also checks the use or initialization of variables and constants like most modern environments.
But Wollok takes validations to an extra level: it avoids bad practices like `if (expression) return true else false` constructions, redefining methods that only call super, defining constructors that don't initialize constant references, defining a class structure with circular references, and many more things.

And most importantly, each year these validations are incorporated and reviewed according to the practical work done by students and the experience we gain in the classroom.
Yes, the written code feeds back into the language.


![image](/assets/tour/validator/linter.png)

A sample of how the validator works.
When positioning the mouse over the underlined element, the description of the warning (in yellow) or error (in red) expands.
In the Problems tab, we have a summary of all the _issues_ from each of the projects.


### How to view the Problems tab?
To activate it, press `Ctrl + Shift + M` or from the menu `Window > Problems`.
There, the different types of problems are grouped (error, warning, information).

### Can I run a program with errors or warnings?
The answer is **yes**: in the case of warnings, they are ignored when running a program, a test, or
the REPL console.
In the case of errors, it will try to execute but there's no guarantee it will reach a result, since the error may prevent the normal execution of the software you created.

