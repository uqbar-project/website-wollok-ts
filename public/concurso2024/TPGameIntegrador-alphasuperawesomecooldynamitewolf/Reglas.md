Nombre del juego:
Defensor del Castillo

Objetivo del juego:

Proteger el castillo de las oleadas de enemigos que avanzan desde un extremo del mapa.
Si los enemigos llegan al castillo y lo destruyen → Game Over.
Si eliminás todos los enemigos de una oleada → ganás monedas y pasás al siguiente nivel.

## Menú principal: Inicio, Controles, Y hasta se puede sumar una guía de c/ torre y enemigo para entender el juego y sus elementos.
## Dentro del juego: Controles con acciones rápidas a la vista, como pausa, reiniciar nivel, volver a menu principal.
## Al finalizar el juego Pantalla de "Fin de Juego" con opciones para reiniciar nivel o volver a menu principal


Mapa:
## Mapa con recorrido para los enemigos, no con movimiento libre por el tablero. Puede haber mas de un tipo de recorrido y enemigos generados que prefieran un camino u otro para dar aleatoriedad.
## Objetos invisibles como recurso para determinar limites, mecanicas necesarias, o incluso para enemigos de mayor tamaño (boss)
## Generacion de mapas por clases (¿semilla procedural?)

Enemigos:
Aparecen desde un borde del mapa (por ejemplo, lado izquierdo).
Se mueven automáticamente hacia el castillo.
Cada enemigo tiene:
vida
velocidad
daño (cuánto le quita al castillo si llega podria hacer que el castillo tenga 3 vida y cada enemigo saca una)
valor (monedas que puede soltar al morir)
Regla:
Cada vez que muere un enemigo, suelta 1 moneda aleatoria en el mapa.
## Drop de elementos/monedas en mapa (juego desvariados y magos vs slime)

Castillo:
Posición fija en el mapa (por ejemplo, en la derecha).
Atributos:
vida total (ej. 100 puntos o 3 corazones)
Método estaDestruido() → devuelve true si la vida ≤ 0
Regla:
Si la vida del castillo llega a 0 → Game Over.

Armas:
Cada torre se coloca usando un número o una tecla del teclado (por ejemplo, 1, 2 o 3).
## Se pueden utilizar otro grupo de teclas (como w, a, s, d) para mover un cursor secundario que permita seleccionar opciones (tipo de torre/defensa, mejorar, borrar, etc) (juego magos vs slime)
Cada torre tiene atributos:
rango
daño
velocidadDeDisparo
costo (monedas necesarias para colocarla)
nivel (puede mejorar)
Método mejorar() para subir de nivel, aumentando daño, rango o velocidad

Proyectiles:
Se generan automáticamente cuando una torre dispara.
Se mueven hacia el enemigo y le restan vida al impactar.
Regla:
Si un enemigo muere → genera una moneda aleatoria que el jugador puede recoger
## La el drop tiene un tiempo antes de desaparecer
## El ataque de las torres es automático como en todos los tower deffense, la dirección del ataque es fija hacia el "camino" para simplificar las mecanicas limitadas de wollok

Monedas o economía:
Cada enemigo eliminado genera 1 moneda aleatoria.
Las torres cuestan monedas
Las mejoras de torre también cuestan monedas.
Regla:
Si el jugador no tiene monedas → solo puede usar torres ya colocadas.

Oleadas o niveles:
Cada nivel tiene más enemigos, más fuertes o más rápidos.
Nuevos enemigos especiales pueden aparecer (voladores, resistentes opcional). 
Regla:
Si superás la oleada y el castillo sigue vivo → pasás al siguiente nivel.
## Enemigos especiales dependiendo del nivel o si es el boss final con mas defensa, daño pero tambien drop

Controles e instrucciones:
Cursor: Se mueve con las teclas WASD o flechas.
## Cursor como una suerte de puntero con imagen de mira o flecha desfasada al estilo celdas del front mission.
Colocar torres: Presionando 1, 2 o 3 según el tipo de torre.
Mejorar torre: Seleccionando la torre con el cursor y presionando M (por ejemplo).
Visualización de monedas y vida en pantalla.
Regla:
No se puede colocar torre sobre otra ya existente ni demasiado cerca del castillo.
## Fijar una regla recurrente que evalue siempre la celda actual.
## Objeto invisible de x tamaño que establezca el perímetro minimo para las torres, facilita la ejecución sin necesidad de evaluar la distancia en celdas al objeto castillo.