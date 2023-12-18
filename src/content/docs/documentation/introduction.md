---
title: Introducción a Wollok
description: Introducción a la sintaxis de Wollok.
sidebar:
    order: 1
---


## Archivos Wollok ##

Wollok tiene actualmente estos tipos de archivo, cada uno representa un concepto diferente:

* un **Programa Wollok** (.wpgm)
* un **Módulo o Biblioteca Wollok** (.wlk)
* un **Test Wollok** (.wtest)

En las siguientes secciones se explicarán más en detalle.

## Programas Wollok ##

Un programa es una pieza de código ejecutable que consiste en una serie de expresiones que serán evaluadas en forma secuencial. Se puede pensar como el punto de entrada principal (o _main_) de un programa en otros lenguajes.

Por ejemplo:

```wollok
program helloWorld {
   console.println("Hola mundo")
}
```

Este programa simplemente escribe "Hola mundo" en la consola. Las secciones siguientes explicarán cómo entender cada una de las partes que componen la expresión "console.println(...)". Por el momento, se puede pensar como una instrucción de alto nivel que está disponible en cualquier programa.

## Referencias variables y constantes ##

En Wollok existen dos tipos de referencias posibles: variables y constantes. 

Una **variable** es una referencia cuyo valor puede cambiar en cualquier momento. Lo que cambia no es el objeto en sí, sino a qué objeto estoy apuntando con mi referencia.

```wollok
var edad = 10
edad = 11
edad = edad + 1
```

Una **constante** es una referencia que siempre apunta al mismo objeto, por lo tanto es necesario definir el objeto apuntado en el momento de inicializar la referencia. No es una operación válida tratar de cambiar la referencia para apuntar a otro objeto.

Lo que es constante no es el objeto apuntado (que puede cambiar su estado interno) sino la referencia.

```wollok
const edadAdulta = 21

edadAdulta = 18  // ¡ ESTO NO COMPILA !
```

## Comentarios ##

Hay tres tipos de comentarios

* comentarios de una sola línea utilizan la doble barra (//)
* comentarios que ocupan muchas líneas comienzan con /* y terminan con */
* comentarios "wollok-docs" comienzan con /** y terminan con */. Los veremos más adelantes

Ejemplos:

```wollok
const edadAdulta = 21   // comentario de una sola línea

/*
 comentario
 de muchas
 líneas
 */
edadAdulta = 18
```

## Objetos basicos ##

Existen objetos básicos que vienen con la distribución de Wollok. 

### Numeros ###

Los números entienden una gran variedad de mensajes, como las operaciones matemáticas para sumar, restar, etc. Son objetos inmutables, esto quiere decir que 

* su estado interno no cambia
* por ejemplo, la suma de 1 + 2 resulta en un nuevo número que representa al 3. 

```wollok
const a = 1
var b = a + 10  // suma
b = b - 1       // resta
b = b * 2       // multiplicación
b = b / 2       // división
b = b % 2       // resto
b = b ** 3      // elevado al cubo 
5.between(2, 7) // preguntamos si 5 está entre 2 y 7 ==> sí
3.min(6)        // el menor número entre 3 y 6 ==> 3
3.max(6)        // el mayor número entre 3 y 6 ==> 6
(3.1416).truncate(0)  // la parte entera de 3.1416 ==> 3 -- (3.1416).truncate(2) = 3.14
(3.1416).roundUp(0)   // el primer entero mayor a 3.1416 ==> 4  -- (3.1416).roundUp(2) = 3.15
```

Además, Wollok soporta **operadores sufijos** así como también **la operación +=** entre otras tantas variantes, que son _shortcuts_ de otras expresiones.

```wollok
b += 2          // b = b + 2
b -= 1          // b = b - 1
b *= 3          // b = b * 3
b %= 2          // b = b % 2
b /= 2          // b = b / 2
```

### Booleanos ###

Hay dos objetos booleanos representados con los literales **true** y **false**. Son objetos inmutables, la expresión ```true || false``` devuelve un nuevo objeto true.

```wollok
const hecho = true and true
const esTrue = true
const esFalse = false

const seraFalse = esTrue and esFalse

const seraTrue = esTrue or esFalse

const seraTrue = not false
```

Para aquellos que estén acostumbrados a los operadores con símbolos pueden usar esta otra sintaxis:

* **and**: ```a && b```
* **or**: ```a || b```
* **not**: ```!a```

Todas las [operaciones de igualdad](#comparar-objetos-iguales) y [comparación](#comparar-objetos-en-general) retornan objetos booleanos.

### Strings ###

Las cadenas de caracteres se delimitan con una o dos comillas. 

```js
const unString = "hola"
const otroString = 'mundo'
```

También son objetos inmutables (al concatenar "hola" y "mundo" tenemos un nuevo String "holamundo"). 

```wollok
const holaMundo = unString + " " + otroString + "!"   // "hola mundo!"
```

### Fechas ###

Una fecha es un objeto inmutable que representa un día, mes y año (sin horas ni minutos). Se crean de dos maneras posibles:

```wollok
const hoy = new Date()  
        // toma la fecha del día
const unDiaCualquiera = new Date(day = 30, month = 6, year = 1973)  
        // se ingresa en formato día, mes y año
```

Algunas operaciones que podemos hacer con las fechas son:

```wollok
const hoy = new Date()
hoy.plusYears(1)    // nueva fecha un año posterior
hoy.plusMonths(2)   // nueva fecha 2 meses después
hoy.plusDays(20)    // nueva fecha 20 días después.
hoy.isLeapYear()    // si el año es bisiesto
hoy.dayOfWeek()     // el día de la semana: monday, tuesday, etc. 
hoy.month()         // el número de mes
hoy.day()           // el número de día
hoy.year()          // el año
const ayer = hoy.minusDays(1)  //se resta un día para obtener el día de ayer
ayer < hoy          // comparación de fechas => true
const haceUnMes = hoy.minusMonths(1)  
ayer.between(haceUnMes, hoy)  // ayer está entre hace un mes y hoy => true
ayer - hoy         // diferencia en días entre ayer y hoy (en absoluto) => 1
```

### Comparar objetos iguales ###

Las siguientes expresiones comparan si dos objetos son iguales resultan en valores booleanos:

```wollok 
const uno = 1
const dos = 2

const esFalso = (uno == dos)

const esVerdadero = uno == 1

const esVerdadero = (uno != dos)
```

* == nos dice cuándo dos objetos **son iguales**
* != nos dice cuándo dos objetos **no son iguales**

Luego de introducir objetos y clases repasaremos este concepto.

### Comparar objetos en general ###

También tenemos otras expresiones que permiten comparar objetos (por lo general números, pero también Strings y fechas)

```wollok
const esCierto = 23 < 24      // menor que
const esCierto = 23 <= 24     // menor o igual que
const esCierto = 24 > 10      // mayor que
const esCierto = 24 >= 10     // mayor o igual que
```
