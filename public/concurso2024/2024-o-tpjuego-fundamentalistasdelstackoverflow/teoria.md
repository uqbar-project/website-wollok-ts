# Teoría detrás del juego y desarrollo
## Morcilla - Movimiento
Nuestro juega cuenta con un protagonista característico: el perro Morcilla.

Por sobre la interacción de Morcilla con el entorno, existe también complejidad en el funcionamiento interno de Morcilla y su movimiento controlado por el usuario.

El movimiento de Morcilla controlado por el usuario se limita a 2 acciones: caminar horizontalmente (a izquierda o derecha) y saltar
Es mejor empezar por el salto, que es el más complejo y añade complejidad al primero.
Para controlar el salto como un movimiento en dos direcciones (primero sube y luego baja), pudimos haberlo resuelto con un movimiento progresivo hacia arriba y una caída retrasada un tiempo proporcional a la distancia subida. 
Esto habría funcionado perfecto para dar la impresión de salto, siempre y cuando morcilla siempre se mantenga en una misma distancia respecto al suelo.
El problema es que preferimos contemplar la posibilidad de implementar plataformas en el juego, por lo que este mecanismo de salto traería problemas si Morcilla necesitara caer más distancia que la altura que se elevó.
Por ello terminamos definiendo métodos que den un sentido de "gravedad" a Morcilla.


Para ello definimos varios atributos booleanos que nos sirven de *flags* para facilitar el control sobre las posibilidades del usuario

```
  var saltando = false
  var suspendido = false
  var caerActivo = false
```

- *saltando* marca cuándo Morcilla está ascendiendo durante un salto, para que la gravedad no se aplique y Morcilla pueda subir sin inconvenientes
- *suspendido* indica que Morcilla no está en contacto con el suelo, para deshabilitar al jugador la posibilidad de saltar (evitar doble saltos)
- *caerActivo* hace referencia al método **caer( )** de Morcilla:
```
  method caer() {
          if(!caerActivo && suspendido){
          game.onTick(100, "gravedad", {self.gravedad()})
          caerActivo = true
          }
      }
```
El llamado *caer* se realiza internamente en Morcilla con cada movimiento que pueda resultar en una caída (izquierda, derecha o salto). 
Ésto permite que la gravedad no involucre una evaluación eterna de la posición y el estado de caída, sino sólo cuando sea necesaria.
Pero la activación múltiple de este método resulta en una aplicación de la gravedad potenciada, por lo resolvimos utilizar *caerActivo* para que la gravedad solo se active de a una vez.
La acción onTick "gravedad" se desactiva una vez Morcilla ya cayó (momentáneamente es cuando alcanza el suelo, pero luego podrá ampliarse a cuando alcance cualquier plataforma)

Los movimientos a izquierda y derecha son sencillos, excepto por la necesidad de fijar fronteras a izquierda y derecha donde detener el movimiento. 
Debido a la necesidad reiterada de realizar esto, decidimos ampliar la clase ***PositionMutable*** de wollok game para crear una clase ***PositionMejorada*** que hereda la clase anterior pero añade métodos de movimiento limitado.
Por ejemplo:
```
  method goLeftMejorado(pasos, limite) {
          x = (x-pasos).max(limite) 
      }
```

## Morcilla - Entorno de batalla
El juego consiste en diversas pelesa contra jefes (bossfights) configuradas por turnos: un turno de ataque y un turno de defensa o evación de proyectiles.

### Etapa de ATAQUE
Durante el turno de ataque creimos conveniente que Morcilla quede inmovil y el jugador no pueda controlar su movimiento. El ataque se demuestra al jugador con una cinemática (el funcionamiento de las cinemáticas se explicará más adelante).
Para esto Morcilla cuenta con la *flag* ***movimientoActivo***, que es desactivada cuando Morcilla se sitúa en posición de ataque y es reactivada cuando comienza el turno de defensa. 
Estos llamados son realizados por el objeto correspondiente de la clase ***BossFight*** mediante la interfaz *habilitarAtaque( )*

![morcilla clases drawio (2)](https://github.com/user-attachments/assets/d1ee17e3-9fd2-498e-9f3c-d3ef7bc9f080)

La etapa de ataque finaliza cuando el usuario presiona la tecla indicada en pantalla para atacar.

### Etapa de DEFENSA
Como ya fue mencionado, esta etapa es el turno de ataque del jefe enemigo, donde el jugador deberá esquivar proyectiles dirigidos hacia Morcilla. Morcilla cuenta con un número finito de vidas que determinarán cuando el jugador es derrotado.
Ahora el usuario vuelve a tomar control del movimiento de Morcilla y el jefe en cuestión ejecuta una de sus secuencias de ataque. La clase más interesante de esta etapa son los ***Proyectiles***.

![morcilla clases drawio (1)](https://github.com/user-attachments/assets/7bfbae9a-7c0e-4a4d-9157-d387d6c06a7d)

Los proyectiles cuentan con atributos como sentido (dirección y límites), velocidad, retraso (hasta dispararse), posición inicial e id identificatorio. El movimiento de los proyectiles funciona mediante los siguientes métodos:
```
    method direccion() {
        position = new PositionMejorada(x = posicionInicial.x(), y = posicionInicial.y())
        game.addVisual(self)
        game.onTick(velocidad, "proyectil" + id, {self.movimiento()})
    }

    method movimiento() {
        position.horizontalMejorado(sentido.x(), sentido.limiteIzq(), sentido.limiteDer())
        position.verticalMejorado(sentido.y(), 99, -4)
        if(position.x() == sentido.limiteIzq() || position.x() == sentido.limiteDer())
        {
            game.removeVisual(self)
            game.removeTickEvent("proyectil" + id)
        }
    }
```

El id identificatorio permite identificar la acción *onTick* que los hace moverse y así cancelarla al llegar al final de la pantalla. La existencia de varios proyectiles de la misma clase simultánteamente resulta en la creación de múltiples acciones de movimiento para cada proyectil, que de no ser distinguidas por un nombre distinto, generaría que se cancelen la una a la otra de manera indeterminada. 
Junto con su movimiento, los proyectiles evaluarán que, de colisionar con Morcilla, deben hacerle **perderVida( )** (esto se verá más a detalle cuando veamos las hitbox de Morcilla).

Los proyectiles, además, se agrupan en objetos llamados *Ataque*. En definitiva, un ataque es una combinación predeterminada de proyectiles que lanzará un jefe durante su turno de ataque. Los jefes poseen una lista de ataques que se randomizará con cada turno para que, al aplicar el ataque en la cabeza de la lista, el jefe pueda atacar efectivamente en patrones aleatorios (dentro de sus combinaciones de proyectiles predefinidas en cada ataque).

## Morcilla - Hitbox
Según Wikipedia, una caja de colisión (*hitbox*) es una *"técnica invisible comúnmente utilizada en los videojuegos para la detección de colisiones en tiempo real"*. En nuestro caso, las dimensiones visuales de nuestro personaje Morcilla (256x256 píxeles) no coinciden con las dimensiones máximas admitidas para una celda en Wollok (100x100 píxeles). El resultado de esto es que los métodos de *onCollideDo* y *whenCollideDo* no pudieran ser tan precisos como nos gustaría para determinar contacto entre Morcilla y los proyectiles, empeorando la experiencia y el desafío de esquivar ataques. La solución a ello fue crear objetos invisibles (con imágenes completamente transparentes) que devolvieran como posición propia una posición relativa a la de Morcilla. Así, estos 4 objetos que funcionan como *Hitbox* remplazan a Morcilla en los metodos de colisión y permiten que los proyectiles impacten más precisamente y con más fidelidad a lo que ve el jugador en pantalla. El funcionamiento principal de las hitbox se resume en el siguiente código:
```
    method position() = new PositionMejorada(x = morcilla.position().x() + desvioX, y = morcilla.position().y() + desvioY)

    method inicializar() {
        game.whenCollideDo(self, {elemento => elemento.tocaMorcilla()})
    }
```

## Jefes
Los jefes existen y varían su comportamiento en dos escenarios distintos dentro del juego: antes de la batalla y durante la batalla. Junto con los proyectiles, los jefes son los otros objetos que actúan frente a una colisión con Morcilla, aprovechando un polimorfismo con esta otra clase mediante el método *tocaMorcilla()*. Cada jefe tiene además asignada una cinemática que comenzará cuando inicie la batalla. Las batallas son instancias de la clase *Bossfight* que son creadas por cada jefe con la llamada del método *nuevaPelea()*. La funcionalidad del jefe durante la batalla reside en su comportamiento visual, la gestión de su vida y el llamado a sus ataques en cuanto el objeto de *Bossfight* lo ordene. La *Bossfight*, en cambio, es quien dirige los turnos de la batalla y habilita a Morcilla y a cada Jefe para atacar respectivamente.

## Cinemáticas
Para el funcionamiento de las cinemáticas creamos una clase *Cinematica* que aprovecha un listado de frames y el método *onTick* provisto por wollok game para avanzar por la lista. Las animaciones pueden ser de loop infinito (animación de derrota) o finitas. La lógica dentro de la clase es la siguiente:

```
    method empezar() {
        image = frames.head()
        game.onTick(duracionFrame, id, {self.siguienteFrame()})
        game.addVisual(self)  // arbitrario para saber si funciona

        if(!loop)
            game.schedule(self.duracion(), { self.terminar() })
    }

    method terminar() {
        game.removeTickEvent(id)
        game.removeVisual(self)
        frameActual = 0
    }

    method siguienteFrame() {
        if((loop || (frameActual+1 < frames.size()))) {
            frameActual += 1
            image = frames.get(frameActual%frames.size())
        }
    }
```

## Polimorfismo
El polimorfismo presente a lo largo del código se percibe principalmente en el uso de clases y múltiples instancias así como *clases hijas* que comparten métodos con sus *padres* e incluso a veces los sobreescriben. Por ejemplo, tanto los jefes como Morcilla heredan la clase *Personaje*, la cual creamos para facilitar métodos relacionados con mostrar y ocultar las visuales de los personajes. En el caso de Morcilla, es necesario junto con la imagen propia, añadir las visuales de su hitbox para el correcto funcionamiento de las colisiones, por lo que el polimorfismo mediante el llamado *mostrar()* y *ocultar()*, difiere con el resto de personajes (los jefes).
También existe polimorfismo, por ejemplo, en las colisiones con Morcilla. Como ya se explicó anteriormente, el método *tocaMorcilla()* es común a todos los objetos que pueden entrar en contacto con Morcilla, pero cada uno actúa de una manera distina: los proyectiles restan vida a Morcilla, los jefes comienzan su batalla mediante el contacto y la hitbox no hace nada (una de las hitbox específicamente está constantemente en contacto con Morcilla).
