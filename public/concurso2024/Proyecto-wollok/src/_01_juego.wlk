import wollok.game.*
import _03_frames.*
import _02_nivel.*

object juego {
	const property niveles = [nivel1, nivel2, nivel3]
	var property numeroNivel = 0
	
	method iniciar() {
		if(numeroNivel < niveles.size()) self.nivelActual().dimensionarEscenario() else historiaSeis.mostrar()
	}
	
	method nivelActual() = self.niveles().get(self.numeroNivel())
	
	method siguienteNivel() { numeroNivel += 1 }
	
	method detener() { game.schedule(1500, {game.stop()}) }
}
