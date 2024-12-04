import wollok.game.*
import personaje.*
import extras.*
import juego.*

const musicaNivel1 = game.sound("musicaNivel1.wav") 
const musicaNivel2 = game.sound("musicaNivel2.wav") 

const nivel1 = new Nivel(nivel=1, enemigos = monstruosNivel1, bloquesMapa = bloquesMapa1, image = fondoNivel1, sonidoNivel = musicaNivel1, pociones = pocionesNivel1)//crear todo lo que va adentro

const nivel2 = new Nivel(nivel = 2, enemigos = monstruosNivel2, bloquesMapa = bloquesMapa2, image = fondoNivel2, sonidoNivel = musicaNivel2, pociones = pocionesNivel2) //crear todo lo que va adentro
const todosLosNiveles = [nivel1, nivel2]
class Nivel{
  var property position = game.center()
  var property image
  const property nivel
  var property enemigos //Creo que queda mejor monstruo, pero hay que cambiar en nombre todas las veces que aparece
  const  property sonidoNivel
  var property bloquesMapa
  var property pociones 

}

//Crear los objetos
//Y mejorar las colisiones con estos
//ORIGINAL
const bloquesMapa1 = new Bloques(murosNivel =[[1, 5], [2, 3], [2, 4], [2, 6], [2, 7], [2, 8], [2, 9], [2, 10], [2, 11], [5, 9], [5, 10], [5, 11], [6, 9], [6, 10], [6, 11],
[8, 5], [10, 10], [9, 6], [9, 7], [9, 8], [10, 6], [10, 7], [10, 8], [11, 6], [11, 7], [11, 8], [14, 8], [13, 3], [13, 4], [13, 5], [13, 6], [13, 7], [13, 9], [13, 10], [13, 11],
[3, 12], [4, 12], [5, 12], [6, 12], [7, 12], [8, 12], [9, 12], [10, 12], [11, 12], [12, 12], [3, 2], [4, 2], [5, 2], [6, 2], [7, 2], [8, 2], [9, 2], [10, 2], [11, 2], [12, 2]] ,
nivel = 1
)
const bloquesMapa2 = new Bloques(murosNivel = [[2, 3], [2, 4], [2, 5], [2, 6], [2, 7], [2, 9], [2, 10], [2, 11], [3, 11], [6, 3], [7, 9], [7, 8], [7, 7], [7, 3], [8, 9], [8, 8], 
[8, 7], [8, 3], [12, 11], [12, 10], [12, 6], [12, 5], [12, 4], [12, 3], [3, 12], [4, 12], [5, 12], [6, 12], [7, 12], [8, 12], [9, 12], [10, 12], [11, 12], [12, 12], [3, 2], [4, 2],
[5, 2], [6, 2], [7, 2], [8, 2], [9, 2], [10, 2], [11, 2], [12, 2], [3, 12], [4, 12], [5, 12], [6, 12], [7, 12], [8, 12], [9, 12], [10, 12], [11, 12], [12, 12], [3, 2], [4, 2], [5, 2],
[6, 2], [7, 2], [8, 2], [9, 2], [10, 2], [11, 2], [12, 2], [13, 9], [13, 8], [13, 7]],
nivel = 2
)



// const bloquesMapa1 = new Bloques(murosNivel =[[1, 5],[8, 5], [10, 10], [14, 8], [3..12, 12],
// [3..12, 2], [2 , 3..4], [2, 6..11], [5, 9..11], [6, 9..11], [10, 6..8],
// [11, 6..8], [9, 6..8], [13, 3..7], [13, 9..11]] , nivel = 1
// )

// const bloquesMapa2 = new Bloques(murosNivel = [[2, 3..11], [3, 11..12], [3, 2], [4, 2], [4, 12], [5, 2], [5, 12], [6, 2..3], [6, 12], [7, 2..3], [7, 7..9], [7, 12], [8, 2..3], [8, 7..9], [8, 12], [9, 2], [9, 12], [10, 2], [10, 12], [11, 2], [11, 12], [12, 2..6], [12, 10..12], [13, 7..9]],
// nivel = 2
// )

class Bloques{
  const property murosNivel = []
  const property nivel
}
