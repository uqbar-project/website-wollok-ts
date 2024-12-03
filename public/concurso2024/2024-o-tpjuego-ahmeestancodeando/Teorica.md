Magos Vs Slime
    El juego consiste en defender la base de slimes Atacantes, a partir de una variedad de Magos. 

Elementos:

Slimes: Atacantes
    -Slime básico, movimiento uniforme en dirección a la Base, 100 puntos de vida y 50 puntos de daño.
    -Slime ninja: Se mueve de a 2 casillas (puede saltar unidades) y tiene un daño considerable, pero Vida baja.
    -Slime Guerrero: Movimiento uniforme en direccion a la Base, Vida alta, daño bajo.
    -Slime Blessed: Movimiento Uniforme hacia la base. Vida y Daño alto.

Magos: Encargadas de defender la base, su vida, daño y atributos varían según el mago:
    -Mago de Fuego: Lanza proyectiles con 75 puntos de daño que se destruyen al alcanzar a los enemigos o alcanzar el final del mapa.100 puntos de vida.
    -Mago irlandes: Aumenta la generación de dinero, $10 por mago. 100 puntos de vida, no realiza daño a enemigos.
    -Mago de Hielo: Lanza proyectiles penetrantes con 30 puntos de daño que continúa dañando enemigos hasta alcanzar el final del mapa.
    -Mago Piedra: Unida con 300 puntos de vida, no realiza daño a enemigos.
    -Mago Explosivo: Al entrar en contacto con un slime, explota.

Puntos: Utilizado para comprar magos, su generación es automática y la cantidad dependerá de la cantidad de magos irlandeses que haya en el campo. La producción base es de $10 por segundo.

Pala: Elimina Magos del juego.

Tienda: Permite comprar a los magos o seleccionar la pala para eliminarlos.

Base: Se encuentra en el extremo izquierdo de la pantalla, no hay que permitir que los slimes (más de 3) lleguen a la misma. En caso de que uno llegue se eliminan todos de su Fila.

El objetivo del juego es evitar que los slimes lleguen a la base, a partir de la compra y ubicación estratégica de los magos.

Se utiliza polimorfismo para por ejemplo, cuando los slimes reciben daño. Todos los objetos que pueden aparecer en los carriles(plantas, el cursor,slimes) tienen el método recibeDanioEnemigo(_danio), pero solo tiene efecto en los slimes, los cuales van a recibir el daño, mientras que los demas retornan false.
Otro ejemplo es el método disparar() que utilizan los magos. Todos los magos tienen este método, sin importar si disparan o no.

Además, se utiliza ampliamente la comunicación entre los distintos objetos, como es por ejemplo el caso del menú, el cual en base a los inputs que realice el jugador, enviará al objeto generadorDeMagos que clase de enemigo deberá generar y en qué posición.

Se utilizan clases para, por ejemplo, instanciar slimes, ya que tendremos varios objetos slime similares, variando su tipo, que serán generados en el transcurso del juego. El generadorDeEnemigos los instanciará cada cierto tiempo asignandoles que tipo son a los slime.

Diagrama de clases:
![diagrama](https://github.com/user-attachments/assets/f98b45cf-0f3e-408f-a662-3a588bf05337)


