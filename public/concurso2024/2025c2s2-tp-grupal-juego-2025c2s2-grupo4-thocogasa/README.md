# Last Pawn Standing A.K.A. minichess

## trabajo grupal POO1 2c2025 c2

### Integrantes THOCOGASA:
* Correa, THOmas
* COndori, Ivana
* Kakazu, GAbriel
* Fisela, SAntiago
---

## Este juego es una variante de ajedrez en tiempo real (el ajedrez tradicional es un juego de estrategia por turnos)
Puede servir como un tutorial divertido para aprender los movimientos de algunas piezas de ajedrez con una jugabilidad semejante a Plantas vs Zombies.

### Usted controla al Rey blanco que se ubica en la fila 1 (la primera fila del tablero visto desde abajo)

+ El *objetivo* de este nivel es "sobrevivir" a la oleada de peones enemigos que van apareciendo aleatoreamente desde la fila 7 (última fila desde abajo) y van descendiendo hasta la fila 1.
+ El Rey Blanco puede moverse únicamente a izquierda y derecha, comienza con 3 vidas y $100 créditos.

### Recursos
+ Con la tecla 1, si hay recursos suficientes, el Rey compra por $20 y ubica un Peon blanco en la fila 2.
  + Los peones aliados defienden sus posiciones arriba en ambas diagonales, si una pieza contraria llega a dicha casilla de influencia, nuestro peon lo captura automáticamente y ocupa su posicion. 
  + Si un peón blanco asciende hasta la última fila del tablero es "coronado". Se retira del tablero y el jugador recibe $100.
+ Con la tecla 2, incorpora caballos por $50.
  + El caballo come siguiendo el movimiento en "L" solo hacia arriba. 
+ Si nuestro rey pierde todo su HP, también muere.
+ Con la tecla 3 se disparan alfiles por $70. El cual es un proyectil, que aparece y come todo lo que hay en su trayectoria.
  + El alfil se mueve aleatoriamente a una casilla diagonal superior hasta llegar a la ultima fila donde corona 
+ Con la tecla 4 se disparan torres por $100. El cual tambien es un proyectil pero solo tiene una trayectoria vertical y come todo lo que encuentra
+ Coronación: Al llegar a la Ultima Fila las piezas coronan y desaparecn del tablero recuperando creditos dependiendo de la pieza
  + Aclaracion: Los peones y caballos multiplican x 5 su valor de costo al coronar, por otro lado los proyectiles dividen x 4 su valor 

### Enemigos
+ Todas las piezas enemigas descienden hasta la primera fila.
+ En la anteúltima fila ponen en "jaque" a nuestro Rey: tenemos 3 segundos para poner una pieza para evitar perder una vida.
+ Los peones enemigos descienden verticalmente y valen $10 créditos.
+ Las torres enemigas además de descender verticalmente, comen lateralmente piezas aliadas que estén en la misma fila.
+ Los caballos desciencen en movimiento en L y valen 50 créditos igual que la torre.
+ Los alfiles descienden en diagonal una casilla a la vez de forma aleatoria (diagonal izquierda inferior o derecha inferior) y valen $30 créditos
+ Al colisionar con nuestras piezas, ganamos en recursos el valor de la pieza enemiga y la mitad de valor de nuestra pieza.

### COMBOS.
+ Las piezas aliadas tienen un multiplicador por cada pieza que come. Por ejemplo, a la tercer pieza capturada el valor de los créditos obtenidos se multiplica por 3.

## Trucos
+ 3 trucos inspirados en Doom.
+ 1 truco inspirado en Mortal Kombat.
+ 1 truco inspirado en los sims.
+ 1 Pokémon.


[Proyecto To-Do](https://github.com/orgs/obj1unq/projects/3/views/1)