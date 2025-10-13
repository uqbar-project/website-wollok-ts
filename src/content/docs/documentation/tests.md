---
title: Tests
description: Tests en Wollok.
sidebar:
    order: 3
---

## Testeo unitario automatizado ##
Es una herramienta que Wollok ofrece para probar el código de una manera mucho más práctica, confiable y profesional.


En el paradigma de la programación orientada a objetos… ¿Qué queremos probar de un objeto? Principalmente, su comportamiento: queremos enviarle mensajes al objeto y verificar que suceda lo esperado.

### Unitario ###
El tipo de testeo que abordamos se califica como "unitario", porque se basa en identificar unidades significativas del código y probar casos puntuales donde éstas intervengan.

### Automático ###
La característica fundamental de los tests es que se puede automatizar su ejecución y consecuentemente su validación. 


Los tests quedan guardados al igual que el código de la solución propiamente dicha y cuando se desea, se pueden ejecutar todos de una vez, obteniendo un informe del resultado de cada uno de ellos.

### Independiente ###
Cada test se concibe en forma independiente de cualquier otro.
La lógica de ejecución de tests parte del supuesto que cada uno se corre a partir de la situación inicial del sistema, es decir que el ambiente se reinicia entre test y test, garantizando su total independencia.

## Definición de tests ##
Los tests se definen en el mismo proyecto en que está la solución propiamente dicha, pero en archivos aparte con un nombre representativo y con extensión .wtest (que no tenga el mismo nombre que tu archivo .wlk).

Al inicio de nuestro archivo de test debemos importar el archivo .wlk el cual vamos a testear de la siguiente manera:
```wollok
import pepita.*
```

### Assert ###
Es un objeto autodefinido de la biblioteca lib, que entiende los siguientes mensajes: 


**equals** : en primer lugar va el valor que se espera que retorne el mensaje que va en segundo lugar.
```wollok
test "energía inicial de pepita" {
	assert.equals(100, pepita.energia())
}
```

**that**: se espera que la respuesta sea true.
```wollok
test "pepita comienza siendo fuerte" {
	assert.that(pepita.esFuerte())
}
```
**notThat**: se espera que la respuesta sea false.
```wollok
test "pepita vuela muchos kilómetros, y ya no es fuerte" {
	pepita.volar(60)
	assert.notThat(pepita.esFuerte())
}
```
### Describe ###
Identificamos a un conjunto de tests con la palabra reservada **describe** y un nombre expresivo con el cual lo identificamos. Se utilizan { } para delimitar el inicio y fin, agrupando a todos los tests que forman parte de ella.
```wollok
describe "Tests de Pepita" {
    test "energía inicial de pepita" {
	    assert.equals(100, pepita.energia())
    }
    test "pepita comienza siendo fuerte" {
	assert.that(pepita.esFuerte())
    }
    test "pepita vuela y baja su energía" {
	pepita.volar(5)
	assert.equals(85, pepita.energia())
    }
}
```

### Tests ###
Dentro del describe anterior podemos identificar 2 tipos de test, los que se trata de probar mensajes que tienen valor de retorno `energía inicial de pepita` y `pepita comienza siendo fuerte` o se busca probar que funcionen adecuadamente métodos con efecto como volar o comer, se envían primero dichos mensajes y luego el mensaje que se coloca en el assert es uno muy sencillo que se limita a exhibir el efecto causado.


## Ejecución de los tests ##

En el IDE, teniendo seleccionado un archivo de tests, se clickea el botón de ejecutar (En el menú, Ejecutar > Ejecutar <Ctrl F11>).
En caso que se tengan definidos varios archivos de tests, además de ejecutarlos uno por uno de la manera explicada, se los puede correr todos juntos (se selecciona el proyecto, menú, Ejecutar > Ejecutar como > Ejecutar todos los tests del proyecto Wollok).



## Testeo avanzado ##


### Inicialización del describe ###
Dentro del describe, se pueden declarar variables y constantes. Al igual que cuando se definen en objetos o clases, pueden inicializarse ya sea con valores puntuales, instanciando clases existentes o con el valor de retorno de cualquier mensaje. El alcance de estas variables y constantes son todos los tests del describe
```wollok
describe "Tests de Pepita" {
	// son objetos que se usan en todos los tests
	const campana = new Ciudad(consumo = 60)
	const sanMartin = new Ciudad(consumo = 5)

	test "pepita comienza con 100 unidades de energía" {
		assert.equals(100, pepita.energia())
	}
}
```

### Initialize ###
Cuando se requiere realizar previo a cada test otras acciones de configuración de la situación inicial más complejas, para las cuales no es suficiente la inicialización de variables, se puede definir un método initialize que no espera parámetros.
```wollok
describe "Tests de Pepita" {
	// son objetos que se usan en todos los tests
	const campana = new Ciudad(consumo = 60)
	const sanMartin = new Ciudad(consumo = 5)

	// todos los tests parten con pepita teniendo como
	// favoritas a estas dos ciudades
	method initialize() {
		pepita.agregarCiudad(campana)
		pepita.agregarCiudad(sanMartin)
	}
}

```

### Métodos auxiliares ###
Para ciertas acciones que se repiten entre algunos tests pero no son comunes a todos, se pueden definir métodos auxiliares, de igual manera que los métodos de cualquier objeto.
```wollok
describe "Tests de Pepita" {
	// son objetos que se usan en todos los tests
	const campana = new Ciudad(consumo = 60)
	const sanMartin = new Ciudad(consumo = 5)

	// hay tests que prueban cosas diferentes a partir de la misma 
	// situación, por lo que una opción es definir un método
	method realizarViajeLoco() {
	// dado que quilmes solo se usa acá,
	// es conveniente no definir la referencia en el describe
	// sino que quede dentro del test. Además, dentro del mismo
	// test podemos ver cómo está definido o qué representa quilmes,
	// lo que ayuda a entender mejor lo que estamos probando.
		const quilmes = new Ciudad(consumo = 1)
		pepita.cumplirDeseo()
		pepita.agregarCiudad(quilmes)
		pepita.cumplirDeseo()
		pepita.cumplirDeseo()
	}
}
```

## Testeo de errores ##

Para poder testear un error, el test se debe escribir dentro de un bloque de código que le pasamos al objeto assert enviando el mensaje throwsExceptionLike. Esperamos que dentro de ese código se produzca una excepción.

Mensajes que conoce el assert:


**throwsException( block )**: es el más básico, en el test esperamos un error (no importa cuál).
```wollok
test "cuando quiero sacar un valor alfabetico tira error" {
	assert.throwsException({ monedero.sacar("A") })
}

```

**throwsExceptionWithMessage( errorMessage, block )**: esperamos un error con un mensaje específico (si no coincide el mensaje el test falla).
```wollok
test "cuando quiero sacar más plata de la que tengo tira error" {
	assert.throwsExceptionWithMessage(
		"Debe retirar menos de 500", 
		{ monedero.sacar(1000) }
	)
}
```

**throwsExceptionLike( exceptionExpected , block )**: es la opción más restrictiva, ya que tienen que coincidir, el tipo de excepción y el mensaje de error
``` wollok
test "cuando quiero sacar un monto negativo tira error" {
	assert.throwsExceptionLike(
   		new UserException( message = "La cantidad a retirar debe ser positiva" ), 
   		{ monedero.sacar(-20) }
	)
}
```