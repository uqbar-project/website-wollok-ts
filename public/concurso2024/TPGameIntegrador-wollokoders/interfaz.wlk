import sonidos.*
import otros.*
import juego.*
import cursor.*
import numeros.*

object interfaz {
	var puntaje = null
	var tiempo = null

	method tiempo() = tiempo

    method configurar() {
        game.cellSize(1)
		game.width(1920)
		game.height(1200)
		game.boardGround("main5.jpg")
		sonidos.fondo().play()
    }

    method mostrarMenu() {
        game.addVisual(config)
		instrucciones.iniciarTitileo()
		self.configurarTeclas()
    }

    method configurarTeclas() {
		keyboard.s().onPressDo({
			if(not sonidos.fondo().estaPausado())
				sonidos.silenciarTodo(true)
		})
		
		keyboard.r().onPressDo({
			if(sonidos.fondo().estaPausado())
				sonidos.silenciarTodo(false)
		})

		keyboard.e().onPressDo({
			if(game.hasVisual(config)) {
				instrucciones.detenerTitileo()
				game.addVisual(fondoTablero)
				juego.iniciar()
			}
		})

		keyboard.t().onPressDo({
			if(game.hasVisual(config)) {
				self.retirarVisuales()
				game.addVisual(tutorial)
			}
		})

		keyboard.m().onPressDo({
			self.volverAlMenu()
		})
	}

    method desplegarTarjetas() {
        juego.tarjetasActuales().forEach({ t => game.addVisual(t)})
    }

	method crearCursor() {
		/*
						|  x12  |  x18
		yFilaArriba		|  780	|  870
		yFilaAbajo		|  380	|  250
		xColIzquierda	|  50	|  50
		xColDerecha		|  1610	|  1660
		variacionEnX	|  312	|  322
		variacionEnY	|  400	|  310
		cantFilas		|  2	|  3
		*/
        game.addVisual(
            if(config.tablero() == 1)
                new Cursor(yFilaArriba=780, yFilaAbajo=380, xColDerecha=1610, variacionEnX=312, variacionEnY=400, cantFilas=2)
            else
                new Cursor(yFilaArriba=870, yFilaAbajo=250, xColDerecha=1660, variacionEnX=322, variacionEnY=310, cantFilas=3)
        )
	}

    method mostrarPuntosYTiempo() {
		game.addVisual(textoTiempo)
		tiempo = new Temporizador(x=501, y=99)
		tiempo.descontar()

		textoPuntos.position(game.at(136,108))
		game.addVisual(textoPuntos)
		puntaje = new Marcador(x=349, y=99)
		puntaje.mostrar(0)

		game.addVisual(textoBonus)
		const bonus = new Temporizador(x=1676, y=99)
		bonus.seguimientoBonus()
    }

    method actualizarPuntaje() {
        puntaje.mostrar(juego.puntos())
    }

    method mostrarPuntajeFinal() {
		textoPuntos.position(game.at(801,300))
		game.addVisual(textoPuntos)

		puntaje = new Marcador(x=1014, y=291)
		self.actualizarPuntaje()
		puntaje.mostrar(juego.puntos() + juego.calcularBonus())
	}

    method volverAlMenu() {
		game.clear()
		config.initialize()
        self.mostrarMenu()
	}

    method retirarVisuales() {
		instrucciones.detenerTitileo()
		game.removeTickEvent("temporizador")
        game.removeTickEvent("bonus")
		game.allVisuals().forEach({ v => game.removeVisual(v)})
	}

    method ganar() {
		if(not game.hasVisual(tiempoTerminado)) {
			self.retirarVisuales()
			game.addVisual(ganaste)
			sonidos.ganar().play()
			self.mostrarPuntajeFinal()
		}
    }

	method tiempoTerminado() {
        self.retirarVisuales()
        game.addVisual(tiempoTerminado)
        self.mostrarPuntajeFinal()
	}
}