---
title: Colleciones
description: Colleciones en Wollok.
sidebar:
    order: 4
---

Wollok provee un literal para los **objetos Lista**, una colección que respeta el orden de los elementos ingresados.

La sintaxis es:

```wollok
[ elemento1, elemento2, ..., elementoN ]
```

Por ejemplo:

```wollok
const numeros = [2, 23, 25]

numeros.size() == 3   // true !
numeros.contains(23)  // true !

numeros.remove(23)
numeros.size() == 2   // true

numeros.clear()
numeros.size() == 0   // true
numeros.isEmpty()     // true
```

Como las listas son objetos (una vez más), la forma de interactuar con las listas es a través de los mensajes. 

Para poder utilizar mensajes más interesantes, necesitamos conocer otro objeto muy importante: ¡los [closures](#closures)! también conocidos como **Bloques de Código** o simplemente **Bloques**.

### Conjuntos ###

Wollok también provee un literal para los **objetos Set**, una colección sin elementos duplicados ni orden.

La sintaxis es

```wollok
const numeros = #{2, 23, 25}
```

Nótese tanto el numeral inicial como las llaves que encierran los elementos del conjunto.

### Diccionarios ###

Los diccionarios (también conocidos como _mapas_ en otros lenguajes) son colecciones de pares clave-valor, útiles para poder acceder rápidamente a los elementos por algún valor conocido.

```wollok
>>> const telefonos = new Dictionary()
>>> telefonos.put("ricky", "15-21...")
>>> telefonos.put("poly", "15-42...")
>>> telefonos.get("ricky")
```

Pueden estudiar otros mensajes interesantes como keys(), values(), etc.

### Closures ###

Un _closure_ es un objeto que representa una _porción de código_ que puede evaluarse en cualquier momento, todas las veces que uno quiera. También pueden asignarse a referencia, pasarse como parámetros y ser devueltos como resultado de los métodos. Para una explicación más detallada puede [verse este artículo de wikipedia](http://en.wikipedia.org/wiki/Closure_(computer_programming)).

Wollok soporta closures mediante el uso de literales. 

Veamos un ejemplo:

```wollok
const helloWorld = { "helloWorld" }
const response = helloWorld.apply()		

response == "helloWorld"      // true
```

La primea línea define un closure "helloWorld" que no recibe parámetros. 
La segunda ejecuta el closure enviándole el mensaje **apply()**.

Aquí vemos otro ejemplo con un closure que recibe un parámetro:

```wollok
const helloWorld = { to => "hello " + to }
const response = helloWorld.apply("world")
const response2 = helloWorld.apply("wollok")

response == "hello world"      // true
response2 == "hello wollok"    // true
```

Entonces, la sintaxis para closures es:

```wollok
{param1, param2, ..., paramN => /* code */ }
```

Un dato importante de los closures es que no solo acceden a sus parámetros, sino también a cualquier otra referencia en el contexto donde fueron definidas. Esto las vuelve realmente poderosas. Veamos un ejemplo muy sencillo:

```wollok
var to = "world"
const helloWorld = { "hello " + to }
			
helloWorld.apply() == "hello world"       // true
		
to = "wollok"
helloWorld.apply() == "hello wollok"      // true
```

Se podrá ver que el closure accede a la variable "to" que es definida fuera del contexto del closure mismo, dentro del programa. Si cambiamos esta referencia, este efecto se propaga al closure (como se muestra en la segunda llamada, el valor devuelto es diferente).


### Closures y colecciones ###

Como la mayoría de los lenguajes, Wollok provee una rica interfaz para operar con colecciones. Esto evita escribir código tedioso y repetitivo para filtrar, transformar, sumar elementos de una colección. La mayoría de estos mensajes recibe closures como parámetro.

Por ejemplo, para realizar una cierta lógica en cada uno de los elementos, existe el método **forEach**:

```wollok
const numeros = [23, 2, 1]

var suma = 0
numeros.forEach({ n => suma = suma + n })
			
suma == 26      // true
```

En el caso de que el único parámetro que se envíe sea un closure, se pueden evitar los paréntesis. El ejemplo anterior también se puede escribir

```wollok
numeros.forEach { n => suma = suma + n }
```

El **forEach** de un Diccionario trabaja con un par clave junto con su valor.

```wollok
>>> const telefonos = new Dictionary()
>>> telefonos.put("ricky", "15-21...")
>>> telefonos.put("poly", "15-42...")
>>> telefonos.forEach { persona, tel => console.println(persona + " tiene " + tel) }
poly tiene 15-42...
ricky tiene 15-21...
```

Para saber si todos los elementos cumplen una determinada condición, existe el mensaje **all**

```wollok
[3, 1].all { n => n > 0 } // true
```

**filter** devuelve una nueva colección con los elementos que cumplen un criterio.

```wollok
[3, 1, 0, 2].filter { n => n > 1 }  // [3, 2]
```

**map** devuelve una nueva colección con el resultado del mensaje que se le envía a los elementos de la colección original. El mensaje se expresa dentro del _closure_.

```wollok
[10, 12].map { n => n / 2 } // [5,6]
```

