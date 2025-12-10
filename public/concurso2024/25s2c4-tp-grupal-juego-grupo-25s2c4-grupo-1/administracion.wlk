import jugador.*
import wollok.game.*
import objetos.*
import direcciones.*
import gestorSonido.*
import menu.*
import entidadBasicas.*
import niveles.*

//*==========================| Creacion de Objetos |==========================
const jugador = new Jugador(position = game.at(2,2), image = "dino_der.png", esPisable= true)

//*==========================| Creacion de Niveles |==========================
const nivel1 = new Nivel(mapa = tunel,posicionPersonaje = game.at(1,5),frasesValidas = #{"Door Is Open"},tiempoDeNivel = 60)
const nivel2 = new Nivel(mapa = elrio,posicionPersonaje = game.at(1,5),frasesValidas = #{"Door Is Open", "Door Is Walkable","Water Is Door","Water Is Walkable"},tiempoDeNivel = 60)
const nivel3 = new Nivel(mapa = labrerintoparedesapuertas,posicionPersonaje = game.at(1,5),frasesValidas = #{"Door Is Open", "Wall Is Door","Door Is Wall"},tiempoDeNivel = 60)
const nivel4 = new Nivel(mapa = elefante,posicionPersonaje = game.at(1,5),frasesValidas = #{"Door Is Open", "Wall Is Walkable", "Wall Is Door","Door Is Wall","Door Is Walkable"},tiempoDeNivel = 60)
const nivel5 = new Nivel(mapa = treshabitaciones,posicionPersonaje = game.at(1,5),frasesValidas = #{"Door Is Open", "Wall Is Walkable", "Wall Is Door","Door Is Wall","Door Is Walkable"},tiempoDeNivel = 60)
const nivel6 = new Nivel(mapa = lacuevaYLaRoca,posicionPersonaje = game.at(1,5),frasesValidas = #{"Door Is Open", "Rock Is Push", "Water Is Evapora", "Wall Is Door","Door Is Wall","Rock Is Door","Door Is Rock","Door Is Walkable","Door Is Push","Water Is Door","Water Is Walkable","Water Is Push"},tiempoDeNivel = 60) //faltan rocas son agua y agua son rocas.


// esto se puede mejorar con estructura de datos.
//*==========================| Mensajes en la pantalla |==========================
const mensajeVictoria = new Mensaje (position = game.at(0,0),image = "alanaIsWin.png")
const mensajeDerrota = new Mensaje (position = game.at(0,0), image = "alanaLose.png")

//*==========================| Factory |==========================
object v {
	method nuevoEn_y_(x, y) {
	}
	method esPisable() = true
}
object d {
	method nuevoEn_y_(x, y) {
		const door = new Palabra(position = game.at(x, y), image = "door.png", esPisable = true, palabra = "Door")
		layers.add(2, door)
	}
}
object i {
	method nuevoEn_y_(x, y) {
		const is = new Palabra(position = game.at(x, y), image = "is.png", esPisable = true, palabra = "Is")
		layers.add(2, is)
	}
}
object o {
	method nuevoEn_y_(x, y) {
		const open = new Palabra(position = game.at(x, y), image = "open.png", esPisable = true, palabra = "Open")
		layers.add(2, open)
	}
}
object w {
	method nuevoEn_y_(x, y) {
		const wall = new Palabra(position = game.at(x, y), image = "wall.png", esPisable = true, palabra = "Wall")
		layers.add(2, wall)
	}
}
object l {
	method nuevoEn_y_(x, y) {
		const walkable = new Palabra(position = game.at(x, y), image = "walkable.png", esPisable = true, palabra = "Walkable")
		layers.add(2, walkable)
	}
}
object k {
	method nuevoEn_y_(x, y) {
		const rock = new Palabra(position = game.at(x, y), image = "rock.png", esPisable = true, palabra = "Rock")
		layers.add(2, rock)
	}
}
object h {
	method nuevoEn_y_(x, y) {
		const push = new Palabra(position = game.at(x, y), image = "push.png", esPisable = true, palabra = "Push")
		layers.add(2, push)
	}
}
object y {
	method nuevoEn_y_(x, y) {
		const evapora = new Palabra(position = game.at(x, y), image = "evapora.png", esPisable = true, palabra = "Evapora")
		layers.add(2, evapora)
	}
}
object e {
	method nuevoEn_y_(x, y) {
		const water = new Palabra(position = game.at(x, y), image = "water.png", esPisable = true, palabra = "Water")
		layers.add(2, water)
	}
}
object m {
	method nuevoEn_y_(x, y) {
		const muro = new Muro(position = game.at(x, y), image = "murito.png", esPisable = false)
		layers.add(0, muro)
		registroDeObjetos.agregarMuro(muro)
 
	}
}
object r {
	method nuevoEn_y_(x, y) {
		const roca = new Roca(position = game.at(x, y), image = "roca.png", esPisable = false, puedeMoverse = false)
		layers.add(1, roca)
		registroDeObjetos.agregarRoca(roca)
	}
}
object p {
	method nuevoEn_y_(x, y) {
		const puerta = new Puerta(position = game.at(x, y), image = "puertaCerrada.png", esPisable = false)
		layers.add(2, puerta)
		registroDeObjetos.agregarPuerta(puerta)
	}
}
object a {
	method nuevoEn_y_(x, y) {
		const agua = new Agua(position = game.at(x, y), image = "agua.png", esPisable = true)
		layers.add(1, agua)
		registroDeObjetos.agregarAgua(agua)
	}
}



