---
title: Avanzado
description: Conceptos avanzados de Wollok.
sidebar:
    order: 6
---


## Mixins ##

Un mixin es una definición similar a la clase en el sentido en que define tanto comportamiento como estado, pero la intención es proveer una funcionalidad "abstracta" que puede ser **incorporada** en cualquier clase u objeto. De esta manera es una opción más flexible y favorece más la reutilización que la herencia basada en clases.

Algunas características de los mixins:

* **no puede instanciarse** (solo se instancian las clases)
* se "lineariza" en la jerarquía de clases para evitar el [problema de los diamantes](https://en.wikipedia.org/wiki/Multiple_inheritance#The_diamond_problem)
* **solo soporta herencia de otros mixines** (un mixin no puede heredar de una clase, aunque una clase puede heredar de una superclase y opcionalmente de muchos mixines)

```wollok
class Ave {}
mixin Volador inherits Ave {}               // INCORRECTO: un mixin no puede heredar de una clase
mixin Volador {}
mixin Planeador inherits Volador {}         // CORRECTO: un mixin puede heredar de otro mixin
```

Otros detalles técnicos

* El proceso de mixing es estático
* no se puede descomponer los mixins de una clase

### Mixin simple ###

Aquí hay un ejemplo del mixin más sencillo posible, que provee un método

```wollok
mixin Flier {
  method fly() {
    console.println("I'm flying")
  }
}
```

Entonces se puede incorporar a una clase

```wollok
class Bird inherits Flier {}
```

Luego podemos usarlo en un programa / test / biblioteca

```wollok
program t {
  const pepita = new Bird()
  pepita.fly()
}
```

### Mixin con estado ###

Además de comportamiento (métodos), un mixin puede definir atributos.

```wollok
mixin Walks {
  var walkedDistance = 0
  method walk(distance) {
    walkedDistance = walkedDistance + distance
  }
  method walkedDistance() = walkedDistance
}
class WalkingBird inherits Walks {}
```

Y se puede usar así

```wollok
const pepita = new WalkingBird()
pepita.walk(10)
assert.equals(10, pepita.walkedDistance())
```

### Acceso a atributos ###

Los atributos declarados en un mixin pueden ser accedidas desde una clase que utilice dicho mixin.

```wollok
class WalkingBird inherits Walks {
  method resetWalkingDistance() {
    walkedDistance = 0     // variable definida en el mixin
  }
}
```

### Mezclando múltiples mixins ###

Una clase puede incorporar varios mixins a la vez.

```wollok
mixin M1 {}
mixin M2 {}

class C inherits M1 and M2 {
}
```

La lista de mixins se debe separar con un "and", indicando el mecanismo de linearización de izquierda a derecha. Esto implica que en este ejemplo:

```wollok
mixin M1 {
  method saludar() = "holu"
}
mixin M2 {
  method saludar() = "holis"
}

class C inherits M1 and M2 {}

program saludin {
  console.println(new C().saludar()) // imprime "holu", tiene precedencia M1 sobre M2
}
```

### Mixins abstractos ###

Un mixin puede ser abstracto si llama a un método que no tiene implementación. En ese caso se produce una **restricción**: la clase, objeto o mixin que quiera incorporar dicho mixin debe definir ese método.

Aquí vemos un ejemplo de un Mixin abstracto que provee capacidades de volar:

```wollok
mixin Flying {
  var fliedMeters = 0
  method fly(meters) {
    self.reduceEnergy(meters)
    fliedMeters = fliedMeters + meters
  }
  method fliedMeters() = fliedMeters
  method reduceEnergy(amount)
}
```

**reduceEnergy(meters)** es un método requerido.

Cuando se ejecuta "self.reduceEnergy()", se enviará un mensaje al objeto actual (self). Esto implica que el método puede estar en cualquier parte de la jerarquía del objeto receptor, como previamente describimos.

Hay tres posibles casos:

#### Método implementado en una clase ####

En este caso la clase provee la implementación del método requerido:

```wollok
class BirdWithEnergyThatFlies inherits Flying {
  var energy = 100
  method energy() = energy
  method reduceEnergy(amount) {
    energy -= amount
  }
}
```

#### Método implementado en una superclase ####

```wollok
class Energy {
  var property energy = 100
  method reduceEnergy(amount) {
    energy -= amount
  }
}

class BirdWithEnergyThatFlies inherits Flying and Energy {
}
```

El método que el mixin requiere no está implementado en la clase que se mezcla con Flying sino en la superclase **que debe definirse al final de la jerarquía**:

```wollok
class BirdWithEnergyThatFlies inherits Flying and Energy {} // CORRECTO, mixins primero y superclase al final
class BirdWithEnergyThatFlies inherits Energy and Flying {} // INCORRECTO, la superclase no está al final
```

Aquí vemos que al agregar el mixin solo se agregan las definiciones propias del mixin a la clase. El _method lookup_ sigue partiendo desde el objeto receptor y subiendo a través de la jerarquía de clases.

#### Método definido en otro mixin ####

Veamos qué sucede si convertimos la clase Energy en un mixin:

```wollok
mixin Energy {
  var energy = 100
  method energy() = energy
  method reduceEnergy(amount) {
    energy -= amount
  }
}
```

Y la usamos de la siguiente manera:

```wollok
class BirdWithEnergyThatFlies inherits Energy and Flying {}
```

En este caso Flying necesita el método **reduceEnergy** que no es implementada por la clase ni por sus superclases, pero sí en el otro mixin (Energy) que forma parte del conjunto de mixins que incorpora BirdWithEnergyThatFlies.

En este caso el orden en el que escribimos los mixins no es relevante, ya que al enviar un mensaje a self comenzamos la búsqueda a partir del objeto receptor que incorpora todas las definiciones de todos los mixins. __Más adelante veremos que el orden de las declaraciones puede ser importante para el method lookup en otras variantes__

### Linearization ###

Los mixins se conectan a la jerarquía de clases mediante un algoritmo que se llama _linearization_. __Esta es básicamente la misma forma en la que funcionan los traits / mixins de Scala__ (para profundizar al respecto puede verse [este blog](https://blog.10pines.com/2014/10/14/mixins-or-traits/)).

Este mecanismo "aplana" las relaciones entre clases y mixins, asegurando que solo quede una jerarquía lineal entre ellas. De esa manera la jerarquía queda como una lista ordenada para que el mecanismo de _method lookup_ tenga un flujo predecible y el programador no tenga que tomar decisiones.

Aquí hay algunos ejemplos de "linearizations":

```wollok
mixin M1 {
}
class A {}

class B inherits M1 and A {}
```

La jerarquía de B es fácil de entender, porque queda en el mismo orden en que la escribimos:

```bash
B -> M1 -> A
```

Si agregamos un nuevo mixin:

```wollok
class B inherits M2 and M1 and A {}
```

La nueva jerarquía quedaría como

```bash
B -> M2 -> M1 -> A
```

Como hemos visto en uno de los ejemplos anteriores, los mixins del lado derecho tienen menos precedencia en la jerarquía, ya que el method lookup se resuelve de izquierda a derecha.

```wollok
mixin M1 { ... }
mixin M2 { ... }
mixin M3 { ... }
mixin M4 { ... }
mixin M5 { ... }
mixin M6 { ... }

class A { ... }
class B inherits M2 and M1 and A { ... }
class C inherits M3 and B { ... }
class D inherits M4 and M5 and M6 and C { ... }
```

La cadena de resolución para D queda

```bash
D -> M4 -> M5 -> M6 -> C -> M3 -> B -> M2 -> M1 -> A
```

### Redefinición de métodos ###

Entender el proceso de "linearization" es importante para implementar mixins en forma modular que colaboran sin conocerse entre ellos. A continuación presentaremos casos más complejos donde una clase o mixin redefine un método.

#### Clase que redefine un método de un mixin ####

La clase tiene prioridad por sobre los mixins dado que está a la izquierda en el algoritmo que lineariza los elementos, por lo tanto puede redefinir un método definido en un mixin.

Dado el siguiente mixin

```wollok
mixin Energy {
  var energy = 100
  method reduceEnergy(amount) { energy -= amount }
  method energy() = energy
}
```

Una clase puede incorporar el mixin Energy y redefinir el método "reduceEnergy(amount)"

```wollok
class Bird inherits Energy {
  override method reduceEnergy(amount) {
    // no hace nada
  }
}
```

Si ejecutamos en la consola 

```wollok
const pepita = new Bird()
pepita.reduceEnergy(10)
pepita.energy()            // 100
```

Veremos que la energía de pepita quedará con el mismo valor.

#### Llamada a super (en una clase que redefine un método de un mixin) ####

Como en cualquier otro método que redefine un método de una superclase, dentro del cuerpo podemos usar la palabra clave **super** para invocar al método original que estamos redefiniendo.

```wollok
class Bird inherits Energy {
  override method reduceEnergy(amount) {
    super(1)
  }
}
```

La misma ejecución en la consola produce el siguiente resultado:smile

```wollok
const pepita = new Bird()
pepita.reduceEnergy(10)
pepita.energy()            // 99
```

#### Llamada a super en un mixin ####

Este es el caso más complejo (y también el más flexible). Un mixin puede redefinir comportamiento y también usar la implementación original. En ese caso la palabra _super_ funciona como una especie de **dynamic dispatch** (si se nos permite la licencia).

Es complejo porque mirando solo la definición del mixin no podemos saber exactamente cuál es el código que estará ejecutando al invocar super().

Por ejemplo:

```wollok
mixin M1 {
  method doFoo(chain) { super(chain + " > M1") }
}
```

¿Dónde está la definición doFoo() que ejecutará super? No lo podemos saber en este contexto, debemos esperar a que una clase utilice M1 en su definición.

Dada esta clase

```wollok
class C1 {
  var foo = ""
  method doFoo(chain) { foo = chain + " > C1" }
  method foo() = foo
}
```

y esta definición

```wollok
class C2 inherits M1 and C1 { }
```

Esto implica tener esta jerarquía lineal:

```bash
C2 -> M1 -> C1
```

Ahora sabemos que la llamada a "super" en el mixin M1 llamará al método "doFoo(chain)" definido en la clase C1 (la superclase de C2). Pero **este es un caso particular**, no podemos generalizar a todos los usos posibles de M1.

> La forma de entender esto es que la jerarquía lineal se construye como hemos visto anteriormente, y entonces "super" implica encontrar la primera implementación existente a partir de la derecha del mixin donde estamos ubicados.

Repasando el ejemplo

```bash
C2 -> M1 (doFoo()) -> C1 (doFoo())
         super --------->
```

### Stackable Mixin Pattern ###

Si tenemos

* un conjunto de mixins que implementan un determinado comportamiento haciendo una llamada a super,
* y una clase que hereda ese mismo comportamiento de una superclase (sin llamar a super)

se produce entonces una situación llamada **stackable mixin pattern**. El efecto que tiene es que cada mixin se ubica como intermediario para "decorar" o agregar funcionalidad. "Stackable" implica que los mixins pueden apilarse o combinarse resultando en una implementación del [chain of responsibility pattern](https://en.wikipedia.org/wiki/Chain-of-responsibility_pattern).

Aquí vemos un ejemplo similar al anterior pero con algunos mixins adicionales

```wollok
mixin M1 {
  method doFoo(chain) { super(chain + "> M1 ") }
}

mixin M2 {
  method doFoo(chain) { super(chain + "> M2 ") }
}

mixin M3 {
  method doFoo(chain) { super(chain + "> M3 ") }
}
```

Y aquí tenemos las clases

```wollok
class C1 {
  var property foo = ""
  method doFoo(chain) { foo = chain + "> C1 " }
}

class C2 inherits M1 and M2 and M3 and C1 {
}
```

Al ejecutar este código

```wollok
const c = new C2()
c.doFoo("Test ")
console.println(c.foo())
```

se imprime por consola lo siguiente

```bash
Test > M1 > M2 > M3 > C1 
```

es decir, la jerarquía lineal obtenida.

### Mixins con Objetos ###

Los objetos autodefinidos (WKOs) también pueden combinarse con mixins

```wollok
mixin Flies {
  var times = 0
  method fly() {
    times = 1
  }
  method times() = times
}

object pepita inherits Flies {}
```

En este caso la cadena queda conformada de la siguiente manera:

```bash
pepita -> Flies -> wollok.lang.Object
```

Una vez más aplican las mismas reglas para la _"linearization"_, el objeto definido como 'pepita' tiene prioridad ya que está a la izquierda de la cadena, por lo tanto puede redefinir cualquier método.

Lo complementamos ahora con herencia de clases

```wollok
class Animal {
  method run() { ... }
}

object pepita inherits Flies and Animal {}
```

### Mixins en la instanciación ###

Los mixins pueden definirse en el momento que instanciamos un nuevo objeto. Esto nos permite una mayor flexibilidad, ya que no necesitamos crear una nueva clase que únicamente combine el conjunto de clases y mixins de una jerarquía. De esa manera evitamos la proliferación innecesaria de clases.

Aquí tenemos un ejemplo: dada la siguiente clase y el siguiente mixin

```wollok
mixin Energy {
    var energy = 100
    method energy() = energy
}
class Warrior {
}
```

En lugar de crear una nueva clase para combinarlos...

```wollok
class WarriorWithEnergy inherits Energy and Warrior {}
```

podemos directamente instanciar un nuevo objeto que los combine

```wollok
program t {
  const w = object inherits Energy and Warrior {}
  assert.equals(100, w.energy())
}
```

Las mismas reglas aplican a combinaciones de mixins.

Aquí tenemos un ejemplo un poco más complejo

```wollok
mixin Energy {
    var property energy = 100
}

mixin GetsHurt {
    method receiveDamage(amount) {
        self.energy(self.energy() - amount)
    }
    method energy()
    method energy(newEnergy)
}

mixin Attacks {
    var property power = 10
    method attack(other) {
        other.receiveDamage(power)
        self.energy(self.energy() - 1)
    }

    method energy()
    method energy(newEnergy)
}

class Warrior {
  var property name = "Leo"
}
```

Luego lo usamos de la siguiente manera

```wollok
program t {
    const warrior1 = object inherits GetsHurt and Energy and Attacks and Warrior {}
    assert.equals(100, warrior1.energy())

    const warrior2 = object inherits GetsHurt and Energy and Attacks and Warrior {}
    assert.equals(100, warrior2.energy())

    warrior1.attack(warrior2)

    assert.equals(90, warrior2.energy())
    assert.equals(99, warrior1.energy())
}
```

### Inicialización de referencias en la linearización ###

El mecanismo de linearización permite inicializar las referencias de cada abstracción: solo debemos encargarnos de pasarle el valor en el lugar donde esté definida dicha referencia. En el ejemplo anterior:

```scala
// IMPORTANTE: no mezclar referencias, Wollok valida que existan en cada abstracción
const warrior1 = object inherits GetsHurt and Energy(energy = 150) and Attacks(power = 20) and Warrior(name = "Mati") {
  ...
}
```

### Herencia de mixins ###

Es posible que un mixin tome definiciones de otro. En el mismo ejemplo anterior, podríamos pedir que el mixin GetsHurt herede de Energy:

```wollok
mixin Energy {
    var property energy = 100
    method reduceEnergy(amount) {
    	energy = energy - amount
    }
}

mixin GetsHurt inherits Energy {
    method receiveDamage(amount) {
        self.reduceEnergy(amount)
    }
    method energy()
    method energy(newEnergy)
}

mixin Attacks {
    var property power = 10
    method attack(other) {
        other.receiveDamage(power)
        self.energy(self.energy() - 1)
    }

    method energy()
    method energy(newEnergy)
}

class Warrior {}
```

El programa queda: 

```wollok
const warrior1 = object inherits GetsHurt and Attacks and Warrior {}
console.println(warrior1.energy())
assert.equals(100, warrior1.energy())
```

### Limitaciones ###

#### Mixins de métodos nativos ####

No queda claro de qué manera los mixins pueden combinarse con clases nativas  :^P

### Redefiniendo comportamiento sobre un objeto anónimo ###

Podemos definir un objeto que linearice de mixines y clases y defina su propio comportamiento, como vemos en este ejemplo:

```scala
class Animal {
	var property name
}

mixin Flies {
	var property height = 100
	method fly() {
		height = height + 10
	}	
}

const pepitaFliesDouble = object inherits Flies(height = 25) and Animal(name = "pepita") {
    override method fly() {
        super()
        super()
    }
}
```

## Type System ###

El sistema de tipos de Wollok (Wollok Type System) es una funcionalidad opcional, que por defecto está activado pero puede apagarse en la configuración. El sistema de tipos permite ocultar la información explícita de tipos, ya que para los desarrolladores novatos esto implica tener que explicar/entender un nuevo concepto.

#### Type System - Parte I ####

En un primer momento, se comienza a partir de un sistema de tipos que solo incluye objetos predefinidos, objetos definidos por el usuario y literales: números, strings, booleanos, listas, conjuntos, closures, entre otros.

#### Type System - Parte II ####

El sistema de tipos de Wollok permite combinar clases con objetos, chequear que los envíos de mensajes sean correctos y que los tipos en las asignaciones sean compatibles.

Todo esto sin necesidad de anotar ningún tipo en las definiciones de las variables, los parámetros o los valores devueltos por los métodos.

Por ejemplo

```wollok
class Ave {
    method volar() { ... }
    method comer() { ... }
}

class AveQueNada inherits Ave {
    method nadar() { ... }
    override method volar() { ... }
}

class Superman {
    method volar() { ... }
    method tirarLaserDeLosOjos() { ... }
}
const pepita = new Ave()
const pato = new AveQueNada()

object juan {
  var mascota
  method hacerVolar() {
    mascota.volar()
  }
}
```

Estos son los tipos que infiere Wollok:

* pepita : se tipa a **`Ave`**
* pato : se tipa a **`AveQueNada`**
* mascota : se tipa a **`Ave|Superman`**, que significa que puede ser una instancia de Ave (o sus subclases) o de Superman. Esto es porque los mensajes que se le envían a la mascota, en este caso **volar()**, es implementado en dichas clases. Que en AveQueNada se redefina **volar()** no altera la inferencia.

Si en otra parte del código se asigna a la variable mascota un objeto de otra clase, se producirá una advertencia acerca de la inconsistencia de tipos de datos.

## WollokDocs ###

Wollok tiene una sintaxis especial para documentar los elementos del lenguaje.

Por ejemplo, las clases:

```wollok
/**
 * A bird knows how to fly and eat.
 * It also has energy.
 *
 * @author jfernandes
 */
class Bird {
   // ...
}
```

Los métodos y las referencias (variables de instancia) también pueden tener este tipo de documentación. Esto facilita el entendimiento posterior para quien lo quiera usar después, ya que el IDE muestra esa documentación en los _tooltips_ y otras partes visuales.

## Mecanismo de excepciones ###

Wollok provee un mecanismo de excepciones similar al de Java / Python.

Una excepción representa una condición en la que no pueden continuar enviándose mensajes los objetos involucrados en resolver un requerimiento, por lo tanto **tira una excepción**.

Eventualmente en alguna otra parte un interesado podrá manejar esta situación para reintentar la operación, tratar de resolverlo, avisar al usuario, etc.

Así que estas son las dos operaciones básicas que pueden hacerse con una excepción:

* **throw**: "tirar" una excepción hasta que alguien la atrape
* **catch**: atrapar la excepción que se encuentra en la pila de ejecución, definiendo código para manejar esa excepción.

#### Throw ####

Veamos un código de ejemplo de la sentencia throw:

```scala
class MyException inherits wollok.lang.Exception {}
class A {
  method m1() {
    throw new MyException()
  }
}
```

Aquí el método m1() siempre tira una excepción, que es una instancia de MyException.

**Importante:** solo puede hacerse throw de instancias que formen parte de la jerarquía de *wollok.lang.Exception* (esto es Exception o sus subclases).

#### Try-Catch ####

Aquí tenemos un ejemplo de cómo atrapar una excepción:

```scala
program p {
  const a = new A()
    const otroA = new A()

  try {
    a.m1()
    ...
  }
  catch e : MyException {
    otroA.m1()
  }
}
```

Este programa atrapa cualquier MyException que se tire dentro del código encerrado en el **try**.

#### Then Always ####

Además del bloque "catch", un bloque "try" puede definir un bloque "always", que **siempre** se ejecutará sin importar si hubo un error o no.

```scala
try {
  a.m1()
}
catch e : MyException
  console.println("Exception raised!") // OK!
then always
  counter = counter + 1
}
```

#### Catchs multiples ####

Un bloque try puede tener más de un catch, en caso de necesitar manejar diferentes tipos de excepción de distinta manera:

```scala
try
  a.m1()
catch e : MySubclassException
  result = 3
catch e : MyException
  result = 2
```

## Sobrecarga de operadores ###

Dado que Wollok no exige definiciones de tipos al usuario, no es posible definir dos mensajes con igual cantidad de parámetros y diferente tipo:

```wollok
ave.volar(6)        // kilómetros
const madrid = new Ciudad(nombre = "Madrid")
ave.volar(madrid)
```

Ambos mensajes serán ejecutados por el mismo método.

No obstante, sí es posible definir dos mensajes con diferente cantidad de argumentos:

```wollok
ave.volar(6)
const madrid = new Ciudad(nombre = "Madrid")
ave.volar(madrid, new Date())
```

## Identidad vs Igualdad ###

Wollok sigue las convenciones de igualdad e identidad que tienen Java / Smalltalk. Por defecto, dos objetos son iguales si son el mismo objeto, y utilizamos el mensaje `==`.

```wollok
class Mail {
 const property asunto
 const property emisor
 const property receptor
}

const invitacion10Oct = new Mail(asunto = "Asado?", 
      emisor = "dodain@gmail.com", receptor = "alf@gmail.com")
const unMail = invitacion10Oct

unMail == invitacion10Oct   ==> true, son el mismo objeto
```

Pero si redefinimos el mensaje `==`, podemos indicar que dos objetos **pueden representar el mismo mail** si tienen el mismo asunto, el mismo emisor y el mismo receptor:

```wollok
class Mail {
 const property asunto
 const property emisor
 const property receptor


 override method == (otroMail) = 
   asunto == otroMail.asunto() &&
   emisor == otroMail.emisor() &&
   receptor == otroMail.receptor()
}

const invitacion10Oct = new Mail(asunto = "Asado?", 
  emisor = "dodain@gmail.com", receptor = "alf@gmail.com")

const invitacion17Oct = new Mail(asunto = "Asado?", 
  emisor = "dodain@gmail.com", receptor = "alf@gmail.com")

> invitacion17Oct === invitacion10Oct  // el mensaje `===` pregunta por identidad
✓ false   // no apuntan al mismo objeto...
> invitacion17Oct == invitacion10Oct
✓ true    // ...pero representan el mismo mail
```

El operador == es equivalente al mensaje equals:

```wollok
> invitacion17Oct.equals(invitacion10Oct)
✓ true    // representan el mismo mail
```

En general, hay objetos que representan valores: los números, los strings, los booleanos, y los [value objects](https://en.wikipedia.org/wiki/Value_object), a ellos se les suele redefinir el == / equals en base a su estado.

Para más información ver el paper de Wollok en el que se habla de [igualdad e identidad](https://docs.google.com/document/d/18QtQCs91tXX1e4kpEPs4sLU-TRJsxcoEKVngMDf278c/edit#heading=h.hryrt6t60c2h) entre otros conceptos.
