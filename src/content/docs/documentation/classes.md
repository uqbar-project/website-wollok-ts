---
title: Clases
description: Clases en Wollok.
sidebar:
    order: 4
---


Las clases comparten algunas características con los objetos literales: definen variables de instancia y métodos. Pero no son expresiones (no pueden asignarse a variables), sino **definiciones**.

Veamos un ejemplo:

```wollok
class Ave {
    var energia = 0

    method volar(metros) {
        energia = energia - (2 + metros)
    }
    method comer(comida) {
        energia = energia + comida.energia()
    }
    method energia() {
        return energia
    }
}
```

### Instanciacion ###

Para crear un Ave instanciamos un objeto de esa clase con la palabra reservada **new**, la cual retorna un objeto de la clase Ave:

```wollok
const pepita = new Ave()
pepita.volar(23)
```

Al crear un objeto, se le puede dar valores iniciales a cada uno de sus atributos, para que el objeto que se obtiene quede completo y consistente. Entre los **( )** se indica el identificador de cada una de las referencias y su valor inicial. Como se indica el nombre de cada atributo, no es necesario mantener un orden en particular en el envío de parámetros.

```wollok
const pepita = new Ave(energia = 100)
```

Hace que pepita quede inicializada con 100 de energía.

Para las referencias de la clase que tienen un valor seteado por defecto es opcional enviar por parámetro el valor, en cambio para las referencias sin inicializar en la definición de la clase es obligatorio enviar por parámetro el valor inicial.

```wollok
class Ave {
    var energia = 0
    var peso
    //...
}

const pepita = new Ave(energia = 100, peso = 1) // Válido (energía se inicializa en 100, peso en 1)

const pepita = new Ave(peso = 1, energia = 100) // Válido (idem)

const pepita = new Ave(peso = 2)                // Válido (energía se inicializa en 0, peso en 2)

const pepita = new Ave(energia = 100)           // Error (Falta inicializar peso)

const pepita = new Ave()                        // Error (Falta inicializar peso)
```

## Herencia ##

Al definir una clase, se puede especificar que **hereda** de otra clase. A la nueva clase se la llama **subclase** y a la de cual se hereda, **superclase**. Esto permite que los objetos que se instancien de la subclase, además de tener los atributos y métodos definidos en ella, también cuenta con los definidos en la superclase.  

Ejemplos:

```wollok
class AveNadadora inherits Ave {

   method nadar(metros) {
       energia = energia - (metros * 1.2)  // Utiliza la variable energia declarada en la superclase
   }
}

const eva = new AveNadadora()
eva.nadar(10)
eva.volar(50) //el objeto eva entiende el mensaje, porque hereda el método de la clase Ave
```

Las subclases pueden agregar nuevos métodos y variables y pueden redefinir métodos existentes (para más información ver [Redefinición y super](#redefinicion-y-super)).

### Clases abstractas ###

Un **método abstracto** declara su nombre y sus parámetros, sin implementarse. Es tarea de cada subclase proveer una implementación del método mediante la [redefinición](#redefinicion-y-super)

Para definir un método abstract en Wollok, simplemente no se escribe el cuerpo del método, sin ninguna palabra reservada.

```wollok
class MyClass {

   method anAbstractMethod(param)

}
```

Una clase con al menos un método abstracto se considera una **clase abstracta**. De nuevo, no hay ninguna palabra para indicar que una clase es abstracta, ya que es información que se puede inferir de la definición misma de la clase.

### Redefinicion y super ###

Las subclases pueden redefinir métodos ya implementados por su superclase. Para ello, debe explícitamente usar la palabra "override" antes de la definición del método.

```wollok
class AveEficiente inherits Ave {

    override method volar(metros) {
        energia = energia - (metros / 2)
    }

}
```

Si al redefinir un método necesitamos invocar al método original, lo podemos hacer mediante la palabra reservada **super**:

```wollok
class Ave {
    var energia = 0

    method volar(metros) {
        energia = energia - (2 + metros)
    }
    method comer(comida) {
        energia = energia + self.energiaObtenida(comida)
    }

    method energiaObtenida(comida) {
        return comida.energia()
    }

}

class AveEficiente inherits Ave {

    override method energiaObtenida(comida) {
        return super(comida) / 2
    }
}
```

Como puede verse, no es necesario especificar el nombre del método. En Wollok solo puede invocarse al método sobreescrito usando **super**. No es posible usar super para llamar a cualquier otro método en la superclase (porque además conceptualmente no es correcto).

Esto mantiene simple el lenguaje.

De la misma manera, super solo puede utilizarse en el contexto de un método que redefine otro.


#### Herencia de Objetos ####

Los objetos autodefinidos pueden definirse en base a una clase existente.

```wollok
object lassie inherits Dog {
   // ...
}
```

Esto permite la migración natural de objetos a clases de un programa que inicialmente comienza con objetos y luego parte del comportamiento se muda a definiciones de clase para reutilizar código. A veces no es necesario convertir todos los objetos a clases, Wollok permite combinar ambos en conjunto.

Si la instanciación de la clase Dog requiere de parámetros, estos se inician en la definición del objeto, similar al new.

```scala
class Dog {
   var name
   var age
      // ...
   }
}

object lassie inherits Dog(name = "Lassie", age = 3) {
   // ...
}
```


## Polimorfismo ##

Wollok combina objetos y clases en un solo lenguaje. El polimorfismo con objetos que se instancian a partir de clases funciona de la misma manera que con los objetos autodefinidos. No importa si un objeto es instancia de una clase, está definido por si mismo o incluso si es un objeto anónimo, todos pueden ser potencialmente usados en forma polimórfica.

**Dos o más objetos pueden usarse en forma polimórfica si todos entienden un conjunto común de mensajes**

```wollok
package aves {

   class Ave {
        method volar() {
             // ...
        }
   }

   class Avion {
        method volar() {
            // ...
        }
   }

}
```
Entonces:

```wollok
const avion = new Avion()
const pepita = new Ave()

const objetosQueVuelan = [ avion, pepita ]

objetosQueVuelan.forEach { volador => volador.volar() }
```

No es necesario tener una superclase común para objetos para ser tratados polimórficamente. Como se dijo antes, lo único importante son los mensajes que entienden los objetos. *Olvídense de la clase, ¡podría ni siquiera tenerla!*

Tanto las clases Avion como Ave son parte de diferentes jerarquías, pero sus instancias siguen siendo polimórficas para cualquier otro objeto que las quiera hacer volar.

De todas maneras, el compilador es capaz de chequear si el mensaje que enviamos es válido.

Como ya se dijo, puede haber polimorfismo entre objetos definidos de diferente manera:

```scala
object boomerang {
        method volar() {
            // ... va, y viene
        }
}

const objetosQueVuelan = [ new Avion(), boomerang, object { method volar() {/*hace algo*/ } } ]

objetosQueVuelan.forEach { volador => volador.volar() }
```

## Modularizacion ##

Wollok provee una serie de reglas y construcciones del lenguaje para fomentar programas modulares: separar clases y programas para ser usado por otros programas / bibliotecas.

### Packages ###

Un package es una unidad lógica que agrupa varias clases y objetos.

```wollok
package aves {

   class Ave {
        // ...
   }

   class AveQueNada inherits Ave {
        // ...
   }

   // ...

}
```

Cuando se crea un archivo .wlk, el nombre del archivo define el nombre del package por defecto. Ejemplo: si creo un archivo aves.wlk, esto implica definir un package aves...

Un archivo Wollok puede definir más de un package

```wollok
package aves {
    // ...
}

package entrenadores {
    // ...
}

package ambiente {
    // ...
}
```

Cada package tiene un nombre ("aves", "entrenadores", etc.). Cada clase definida dentro toma el nombre del package como prefijo, lo que introduce el **fully qualified name** (FQN) de una clase.

Ejemplo:

```wollok
package aves {

   class AveQueNada {
       // ...
   }

}
```

El FQN de la clase es: **aves.AveQueNada**

Al codificar dentro de un package, podemos referirnos a las clases por su **nombre corto** (en el ejemplo, AveQueNada). Esto es válido mientras estemos dentro del mismo paquete.

Para referirnos a una clase que está fuera del package DEBEMOS usar su FQN. Para evitar escribir una y otra vez los FQN de la clase, podemos usar los imports, como se describe a continuación.


### Imports ###

Para poder acceder a las definiciones de distintas clases, es necesario decirle a Wollok dónde encontrarlas mediante el mecanismo de imports. Por defecto cada archivo Wollok (.wlk) define un package, por lo que al importar definiciones de un archivo tenemos acceso a todos los packages contenidos en él.

Ejemplo: tenemos un archivo definiciones.wlk

```wollok
object pepita {
   var energia = 0
   method volar() { energia = energia - 10 }
}
```

En otro archivo objects.wlk podemos acceder a pepita mediante un import:

```wollok
import definiciones.* // tomar todas las definiciones escritas en definiciones.wlk

object entrenador {
    method entrenar() {
        pepita.volar()
    }
}
```

En el caso de tener varios packages en el mismo archivo, debemos hacer el import de cada uno de los packages involucrados. Si nuestro archivo definiciones.wlk tiene estos packages:

```wollok
package points {
    class ImmutablePoint {
    }
}

package aves {
    object pepita {
        var energia = 0
        method volar() {
            energia = energia - 10
        }
    }
}
```

Entonces debemos cambiar nuestro import del archivo objects.wlk de la siguiente manera:

```wollok
import definiciones.aves.*

object entrenador {
    method entrenar() {
        pepita.volar()
    }
}
```
