// ===============================
// Revisado
// ===============================

import game.*
import administradorDeMagos.*

// ===============================
// Puntaje: Manejo de puntos
// ===============================
object puntaje {
	const puntajeInicial = 200

	var property puntos = puntajeInicial

	method position() = new MutablePosition(x = 7, y = 5)
	method sumarPuntos() { self.puntos(puntos + 5 + administradorDeMagos.magos().map({mago => mago.valorAgregado()}).sum())} // preguntar que opina fede | posiblemente se cambie para la presentacion del concurso
	method restarPuntos(costo) { if (puntos>costo) self.puntos(puntos - costo) else puntos=0 }

	// Métodos para mostrar el puntaje
	method text() = puntos.toString() + "$"
	method textColor() = "#FA0770"

	// Método de reset
	method reset() {
		puntos = puntajeInicial 
	}
	method recibeDanioMago(danio){}
}
