UTN - Facultad Regional Buenos Aires - Materia Paradigmas de Programación

## Equipo de desarrollo:

- Arellano, Ariel Iván
- Davenheimer, Emerson Javier
- Di Bennardo, Juan Ignacio
- Porzolis Requena, Alexis Eduardo

## Introducción

WoToDe es un juego de tipo tower defense, él cual consiste en defender nuestro núcleo vital de los enemigos que buscan destruirlo, para ello podemos crear torres, con distintos efectos, para cubrir nuestra razón de existir.

## Capturas
*Pantalla principal*
![Imagen de la pantalla principal del juego WoToDe](captura_pantalla-principal.png "Pantalla pirncipal de WoToDo")

*Etapa de construcción*
![Modo construcción de torres](captura_construccion.png "Personaje observando rango de torre básica")

*Enemigos en acción*
![Enemigo avanzando en el mapa y siendo ejecutado](captura_enemigo.png "Enemigos avanzando en el mapa")

*Interacción enemigos-torres*
![Enemigos y torres en acción](captura_jugabilidad.png "Torres atacando a los enemigos")

*¡Victoria!*
![Nivel completado satisfactoriamente](captura_victoria.png  "Nivel completado satisfactoriamente")


## Reglas de Juego / Instrucciones

### Instrucciones del juego
> Una vez iniciado WoToDe, el jugador se encontrará en la página principal, dónde debe escoger el nivel que desea jugar. A partir de allí, se encontrará con las siguientes fases:
>
>> **Fase de selección de nivel**: debe presionar la tecla del nivel que quiere jugar.
>
>> **Fase de construcción**: puede colocar tantas torres según la cantidad de monedas que disponga (puede ver el costo de cada torre en el menú lateral).
>
>> **Fase de ejecución de ronda**: los enemigos avanzarán por el camino marcado con el objetivo de llegar al núcleo. Cuando los enemigos mueren, unas bombas aparecen y deben ser desactivadas yendo hasta su posición. 
>
>> **Fase fin de ronda**: cada vez que finalice una ronda, el jugador recibirá oro para poder seguir construyendo más torres.

### Controles:

| Tecla  | Acción |
| ------------- |:-------------:|
| W-A-S-D      | Movimientos del personaje     |
| Q     |  Entrar en modo construccion de torres    |
| 1     |  Cambiar vista a torre básica |
| 2      |  Cambiar vista a torre ralentizante |
| 3      |  Cambiar vista a torre perforante |
| Espacio      | Costruir torre |
| X      | Vender torre  |
| E      | Iniciar o avanzar una ronda |
| R      | Reiniciar el juego  |

### Tipos de enemigos

<img src="./assets/enemy_basic_alive_1.png" alt="Imágen del enemigo básico II" title="Imagen del enemigo común I" width="20"> Enemigo común II: puede recibir daño de cualquier torre.

<img src="./assets/enemy_basic_alive_2.png" alt="Imágen del enemigo básico III" title="Imagen del enemigo común II" width="20"> Enemigo común III: puede recibir daño de cualquier torre.

<img src="./assets/enemy_basic_alive_3.png" alt="Imágen del enemigo básico IV" title="Imagen del enemigo común III" width="20"> Enemigo común IV: puede recibir daño de cualquier torre.

<img src="./assets/enemy_armored_alive.png" alt="Imágen del enemigo con armadura" title="Imagen del enemigo con armadura" width="20"> Enemigo con armadura: únicamente la torre perforante le puede hacer daño.

<img src="./assets/enemy_explosive_alive.png" alt="Imágen del enemigo explosivo" title="Imagen del enemigo explosivo" width="20"> Enemigo explosivo: al ser destruido explota y hace daño en área a los demás enemigos.

### Tipos de torres
<img src="./assets/tower_basic_idle.png" alt="Imágen de la torre básica" title="Imágen de la torre básica" width="20"> Torre básica: hace daño a los enemigos comunes.

<img src="./assets/tower_slowing_idle.png" alt="Imágen de la torre ralentizante" title="Imágen de la torre ralentizante" width="20"> Torre ralentizante: ralentiza al enemigo atacado.

<img src="./assets/tower_piercing_idle.png" alt="Imágen de la torre perforante" title="Imágen de la torre perforante" width="20"> Torre perforante: es la única que puede hacer daño a los enemigos con armadura.

### Consultas 
>> **¿Cómo construyo las torres?**
>>Primero debe presionar la tecla "Q", luego seleccionar la torre que quiere colocar (Tecla #1, #2 o #3) y finalmente tocar la tecla de "Espacio" para confirmar la construcción.
>
>> **¿Cómo ganar?**
>> Pasar todas las rondas antes de que el nucleo se quede sin vida.
>
>> **¿Puedo seguir construyendo torres mientras aparecen los enemigos?**
>> Si.

## Explicaciones teóricas y diagramas

- [Aplicación de conceptos teóricos](./aplicacionTeorica.md)




