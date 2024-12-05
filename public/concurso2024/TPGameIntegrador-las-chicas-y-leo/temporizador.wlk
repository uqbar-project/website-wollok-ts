import wollok.game.*
import mozo.*
import elementos.*
import clientes.*
import configuracion.*
import niveles.*
import textoystatsvisuales.*
object temporizador {
	var tiempo = 150

	method tiempo() = tiempo

	method position() = game.at(16,11)

	method text() = self.transformarTiempo()

	method textColor() = paleta.blanco()

	method reiniciar() {
		tiempo = 150
		game.removeTickEvent("tiempo")
	}

	method pasarSegundo() {
		tiempo -= 1
	}

	method configurarTemporizador(unTiempo) {
		tiempo = unTiempo
	}

	method correrTiempo() {
		game.onTick(1000, "tiempo", {
		self.pasarSegundo()
		if (tiempo == 0) {
			game.clear()
			reinicio.reiniciarTodoElNivel()
			victoria.iniciar()
			//game.addVisual(pantallaVictoria)
		}})
	}

	// MÉTODOS DE FORMATO MM:SS
	method transformarTiempo() {
		const minutos = (tiempo / 60.0).truncate(0)
		const segundosRestantes = tiempo % 60
		return self.formatoTiempo(minutos) + ":" + self.formatoTiempo(segundosRestantes)
	}

	method formatoTiempo(numero) {
        if (numero < 10) {
            return "0" + numero.toString()
        } else {
            return numero.toString()
        }
	}
}

// VISUAL DEL FONDO DEL RELOJ
object cartelReloj {
	method image() = "cartelReloj.png"
	method position() = game.at(16, 11)
}