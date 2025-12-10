# Conceptos Teóricos Aplicados en Level Devil

## ***Polimorfismo***

> Capacidad de los objetos de diferentes clases de responder de manera distinta a un mismo mensaje. Esto permite que un mismo código interactúe con diferentes tipos de objetos de una manera uniforme y flexible.

En este trabajo práctico, aplicamos el concepto de *polimorfismo* en varios contextos:

### Interacción de Colisiones: `interactuarConPersonaje()`

Una aplicación clara de polimorfismo se observa en el método `interactuarConPersonaje()`, implementado por todos los objetos del juego que pueden colisionar con los personajes. Cada tipo de objeto ejecuta una lógica diferente:

- **Meta**: Detiene el juego, reproduce animaciones de victoria y avanza al siguiente nivel
- **Moneda**: Suma puntos temporales y desaparece del mapa
- **MonedaFalsa**: Resta puntos, mata al personaje y desaparece
- **Pincho**: Daña al personaje según su potencial defensivo
- **PinchoMovil**: Se mueve aleatoriamente y causa daño al colisionar
- **PinchoInvisible/PinchoInvisibleInstantaneo**: Solo causan daño cuando el jugador se acerca o toca
- **Piso y Pared**: Permiten o bloquean el movimiento

De esta manera, el sistema de colisiones utiliza un único mensaje que todos entienden, pero cada objeto responde según su naturaleza específica.

### Agregación de Elementos al Nivel: `agregarAlNivel(x, y)`

Otro ejemplo clave de polimorfismo es el método `agregarAlNivel(x, y)`, implementado por la clase `AgregadoDeClasesObjetos` y todas sus subclases (objetos especiales). Cada tipo de elemento en el mapa se agrega de manera diferente:

- **v (vacío)**: No agrega nada al mapa
- **_ (piso)**: Crea una instancia de `Piso` con imagen aleatoria
- **p (pared)**: Crea una instancia de `Pared` con imagen aleatoria
- **m (meta)**: Crea una instancia de `Meta` y la añade al mapa visual
- **d (moneda)**: Crea una instancia de `Moneda` con sonido asociado
- **f (moneda falsa)**: Crea una instancia de `MonedaFalsa`
- **s (pincho)**: Crea una instancia de `Pincho` simple
- **i (pincho invisible)**: Crea un `PinchoInvisible` y activa su detección de proximidad
- **n (pincho invisible instantáneo)**: Crea un `PinchoInvisibleInstantaneo`
- **h (pincho móvil)**: Crea un `PinchoMovil` y inicia su movimiento aleatorio
- **j (jugador)**: Posiciona al jugador actual en el mapa
- **a (flechas)**: Agrega un visual decorativo con instrucciones

El sistema utiliza este polimorfismo durante la lectura del `mapaDeCuadricula()` para construir dinámicamente cada nivel, permitiendo que cada carácter del mapa se convierta en el objeto correspondiente sin necesidad de condicionales.

### Movimiento de Personajes: `moverA()`

El método `moverA()` es implementado de forma diferente por las clases `JugadorCansado` y `JugadorNoCansado`:

- **JugadorNoCansado**: Realiza el movimiento de forma inmediata
- **JugadorCansado**: Aplica un delay basado en la cantidad de movimientos previos, simulando cansancio progresivo

Esto permite que el código cliente llame al mismo método sin necesidad de conocer qué tipo de jugador está siendo controlado.

---

## ***Herencia***

> Mecanismo que permite a una clase adquirir las propiedades y métodos de otra clase, estableciendo una relación jerárquica entre ellas. Esto facilita la reutilización de código, evitando duplicación de lógica y permitiendo crear estructuras más organizadas y extensibles.

### Jerarquía de Personajes

La *herencia* es fundamental en el diseño de los jugadores:

```
Personaje (clase abstracta)
├── JugadorNoCansado
│   ├── jugadorLevelDevil
│   ├── miniMessi
│   └── satoruGojo
└── JugadorCansado
    └── zombie
```

Todos los personajes heredan de `Personaje`, lo que les proporciona:
- Sistema de vidas (`vidasActuales`, `reiniciarVidas()`)
- Sistema de puntos (`puntaje`, `puntajeTemporalGanado`, `puntajeTemporalPerdido`)
- Cálculo de potencial defensivo (`potencialDefensivo()`)
- Manejo de muerte (`morir()`)
- Gestión de imágenes y animaciones

#### Sistema de Potencial Defensivo

El `potencialDefensivo()` es un método en la clase `Personaje` que calcula dinámicamente la capacidad del personaje para resistir daño:

```wollok
method potencialDefensivo() = 10 * vidasActuales + potencialDefensivoExtra
```

**Implementación:**
- Se calcula multiplicando las vidas actuales por 10 y sumando un bono defensivo específico de cada personaje
- El valor se recalcula automáticamente en cada colisión cuando el personaje pierde vidas
- En `ObjetoMortal.interactuarConPersonaje()`, se compara: si `ataque > potencialDefensivo`, el personaje recibe daño

Este sistema demuestra cómo la **herencia permite que todos los personajes compartan la misma lógica defensiva**, pero cada uno puede tener diferentes valores de `vidasActuales` y `potencialDefensivoExtra` según su tipo.

Cada personaje concreto extiende estas funcionalidades con sus características únicas:
- `jugadorLevelDevil`: 1 vida, imagen específica
- `zombie`: 5 vidas, movimiento lento (cansancio = 1)
- `miniMessi`: 4 vidas, sin cansancio
- `satoruGojo`: 3 vidas, imagen especial al morir

### Jerarquía de Objetos Mortales

```
ObjetoMortal (clase base)
├── Pincho
├── MonedaFalsa
├── PinchoInvisibleInstantaneo
├── PinchoInvisible
└── PinchoMovil
```

La clase `ObjetoMortal` define el comportamiento base:
- Cálculo de daño (`ataque()`)
- Interacción con personajes (`interactuarConPersonaje()`)
- Pérdida de puntos al morir (`restaDePuntajeAlMorir()`)

Cada subclase personaliza:
- **Pincho**: Ataque fijo de 180, imagen simple
- **MonedaFalsa**: Ataque alto (500), resta 100 puntos, se elimina al tocar
- **PinchoInvisible**: Solo visible cuando el jugador está cerca, ataque moderado (150)
- **PinchoInvisibleInstantaneo**: Ataque muy alto (400), solo visible al momento de colisionar
- **PinchoMovil**: Se desplaza aleatoriamente, ataque de 250

---

## ***Encapsulación***

> Principio que agrupa datos y métodos relacionados en una unidad, ocultando los detalles internos y exponiendo solo lo necesario. Mejora la seguridad, mantenibilidad y facilita cambios internos sin afectar el código externo.

### Gestión de Personajes: `gestorDeJugadores`

El objeto `gestorDeJugadores` encapsula toda la lógica de interacción con el jugador actual:

```wollok
method moverA(direccion) { ... }
method position() { ... }
method puntaje() { ... }
method vidasActuales() { ... }
```

El resto del código no necesita conocer cuál es el personaje actual ni sus detalles internos. Solo se comunica a través de mensajes bien definidos.

### Gestión de Juego: `juegoLevelDevil`

Centraliza toda la lógica del juego:
- Inicialización y configuración
- Activación de colisiones
- Transición entre niveles
- Manejo de vidas y reintentos
- Limpieza de recursos

---

## ***Abstracción***

> Técnica que simplifica la complejidad ocultando detalles innecesarios y enfocándose en lo esencial. Permite trabajar con conceptos de alto nivel sin preocuparse por la implementación.

### Direcciones de Movimiento

El código utiliza objetos de dirección (`arriba`, `abajo`, `izquierda`, `derecha`) que abstraen la lógica de cálculo de nuevas posiciones:

```wollok
method mover(direccion) {
    const nuevaPosition = direccion.calcularNuevaPosition(self.position())
    self.position(nuevaPosition)
}
```

El personaje no necesita saber cómo se calcula la nueva posición, solo delega al objeto dirección.

### Visualización de Niveles

Los niveles se definen mediante mapas de caracteres, abstracto del sistema de renderizado:

```wollok
// El nivel contiene solo la definición lógica
// El sistema convierte caracteres en objetos visuales
```

---

## ***Patrón Strategy: Comportamiento de Cansancio***

El patrón Strategy se observa en las dos estrategias de movimiento:

- **JugadorNoCansado**: Ejecuta movimiento inmediatamente (Strategy rápida)
- **JugadorCansado**: Aplica delay progresivo (Strategy lenta)

Ambas heredan de `Personaje` pero implementan estrategias distintas de movimiento, permitiendo intercambiar comportamientos dinámicamente.

---

## ***Mapas de Cuadrícula: Definición Declarativa de Niveles***

El sistema utiliza mapas bidimensionales (arrays de arrays) para definir la estructura de cada nivel de forma declarativa y legible. Cada carácter representa un tipo de elemento específico:

### Estructura del Mapa

```wollok
method mapaDeCuadricula() = [
    /* y = 11*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
    /* y = 10*/ [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v],
    /* y = 9*/  [v,v,v,v,v,v,s,p,p,p,p,p,p,p,p,p,_,_,v,v,v,v,v,v],
    // ... más filas ...
    /* y = 0*/  [v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,v,a,v,v,v,v]
]
```

### Ventajas de este Enfoque

1. **Legibilidad Visual**: El diseñador puede ver la estructura del nivel directamente en el código
2. **Mantenibilidad**: Cambiar un nivel es tan simple como modificar el array
3. **Abstracción**: Los nombres cortos (v, p, m, etc.) abstracten la complejidad
4. **Escalabilidad**: Permite agregar nuevos tipos de elementos fácilmente

### Procesamiento del Mapa

El método `dibujarNivel()` procesa el mapa en tres pasadas:

1. **Primera pasada**: Dibuja todos los pisos
2. **Segunda pasada**: Posiciona al jugador y dibuja elementos especiales
3. **Tercera pasada**: Dibuja el resto de elementos (enemigos, objetos, etc.)

Esto garantiza que los pisos estén siempre en el fondo y el jugador sea accesible en las capas superiores.

---

## ***Recursividad***

> Técnica de programación en la que una función se llama a sí misma directa o indirectamente, resolviendo un problema subdividiéndolo en subproblemas más pequeños del mismo tipo. Toda función recursiva debe contar con un caso base (condición de parada) para evitar bucles infinitos.

### Aplicación Real: Contar Niveles Restantes

La recursividad se aplica de manera práctica en el método `cantidadNivelesDesde()` de `juegoLevelDevil`. Este método cuenta cuántos niveles quedan por jugar a partir de un nivel dado:

```wollok
method cantidadNivelesDesde(nivel) {
    // CASO BASE: si no hay siguiente nivel, hemos llegado al final
    if (nivel.siguienteNivel() == null) {
        return 0
    }
    // CASO RECURSIVO: contar 1 + los niveles del siguiente nivel
    return 1 + self.cantidadNivelesDesde(nivel.siguienteNivel())
}
```

### Caso Base y Recursivo

Esta es una implementación clara de los dos componentes esenciales de la recursividad:

- **Caso Base** `(if nivel.siguienteNivel() == null)`: Detiene la recursión
- **Caso Recursivo** `(1 + self.cantidadNivelesDesde(...))`: Avanza hacia el caso base

---

## ***Gestión de Eventos: Game Loop***

El juego utiliza varios mecanismos de eventos:

### `game.onCollideDo()`

Registra handlers para detectar colisiones:

```wollok
if(!jugadoresActivosConColisiones.contains(gestorDeJugadores.jugadorActual())) {
    jugadoresActivosConColisiones.add(gestorDeJugadores.jugadorActual())
    game.onCollideDo(gestorDeJugadores.jugadorActual(), { elemento => 
        elemento.interactuarConPersonaje(gestorDeJugadores.jugadorActual()) 
    })
}
```

### `game.onTick()`

Utilizado para comportamientos repetitivos:

```wollok
// PinchoInvisible: muestra el pincho cuando el jugador está cerca
method hacerVisible() {
    game.onTick(100, tickId, { ... })
}

// PinchoMovil: se mueve aleatoriamente cada 300ms
method moverPinchoMovil() {
    game.onTick(300, tickId, { ... })
}
```

### `game.schedule()`

Para eventos temporizados (animaciones, transiciones):

```wollok
game.schedule(2000, {
    juegoLevelDevil.reiniciarNivel()
})
```

---

## Diagrama Estático Del Juego
![Diagrama Estático de Level Devil](<ImagenesDeReadme/DiagramaEstaticoDeLevelDevil.svg>)