import wollok.game.*
import _08_armas.*
import _04_elementosEnEscenario.*
import _03_frames.*
import _06_animacion.*
import _09_municion.*
import _03_frames.*

class Objeto {
	var property position
	var property image
	
	method serImpactado(objeto) {}
	
	method esMunicionEnemiga() = false
	
	method sumarPuntosPorMuerte(){}
	
	method desactivarFuncionalidades() {}
}

/*Clase general de todos los personajes. */
class Personaje inherits Objeto{
	var vida
	var property estaMuerto = false
	
	method vida() = vida
	
	method morir()
}

/* Objeto que representa al jugador principal del juego. */
object juan inherits Personaje(
	position = game.at(0, 1),
	image = "juanSalvo/Jugador_BaseV1_Perfil_Derecho-96x192.png",
	vida = vidaJuan.vida()
	) {
	var property arma = rifle
    var puedeMoverse = true 
	
    /* Activar las teclas de movimiento y acción del jugador */
    method activarFuncionalidades() {
        keyboard.up().onPressDo{self.moverArriba()}
        keyboard.right().onPressDo{self.moverDerecha()}
        keyboard.down().onPressDo{self.moverAbajo()}
        keyboard.left().onPressDo{self.moverIzquierda()}
        keyboard.s().onPressDo{self.accionarArma()}
        self.efectoDeColision()
    }

    /* Desactivar las funcionalidades del jugador */
    override method desactivarFuncionalidades() {
        puedeMoverse = false
        estaMuerto = true
        arma.estaSobrecalentado(true)
    }
    
    method danio() = 0
    
    /* Causar daño al jugador si colisiona con un enemigo */
    method efectoDeColision() {
        game.onCollideDo(self, { objeto => objeto.serImpactado(self) objeto.desactivarFuncionalidades()})
     }
    
    override method serImpactado(objeto) {
    	vidaJuan.restarVida(objeto)
    }
    
    method usar() {
    	vidaJuan.sumarVida()
    }

    /* Reiniciar todas las funcionalidades del jugador */
    method resetearFuncionalidades() {
        self.volverAlOrigen()
        puedeMoverse = true
        image = "juanSalvo/Jugador_BaseV1_Perfil_Derecho-96x192.png"
        arma.estaSobrecalentado(false)
        vidaJuan.resetearVida()
        puntuacion.resetearPuntuacion()
        estaMuerto = false
    }

    /* Mover al jugador hacia la izquierda */
    method moverIzquierda() {
        if (puedeMoverse) {
            position = game.at((position.x()-1).max(0), position.y())
            self.cambiarImagenAMovimientoIzquierda()
			game.schedule(1000, {if (!estaMuerto) self.revertirImagenOriginal() self.iniciarPeriodoDeEsperaParaMovimiento()})
        }
    }

    /* Mover al jugador hacia la derecha */
    method moverDerecha() {
        if (puedeMoverse) {
            position = game.at((position.x()+1).min(13), position.y())
            self.cambiarImagenAMovimientoDerecha()
            game.schedule(1000, {if (!estaMuerto) self.revertirImagenOriginal() self.iniciarPeriodoDeEsperaParaMovimiento()})
        }
    }

    /* Mover al jugador hacia arriba */
    method moverArriba() {
        if (puedeMoverse)
            position = game.at(position.x(), (position.y()+2).min(3))
    }

    /* Mover al jugador hacia abajo */
    method moverAbajo() {
        if (puedeMoverse)
            position = game.at(position.x(), (position.y()-2).max(1))
    }

    /* Realizar la acción de disparar con el arma del jugador */
    method accionarArma() {
        if (!arma.estaSobrecalentado() && !estaMuerto) {
            arma.atacar()
            self.cambiarImagenADisparo()
            game.schedule(800, { if (puedeMoverse && !estaMuerto) self.revertirImagenOriginal() })
        }
    }

    /* Cambiar la imagen del jugador al moverse hacia la derecha */
    method cambiarImagenAMovimientoDerecha() {
        image = "juanSalvo/Jugador_V1_Caminar_Derecha_1-176x192.png"
        self.actualizarImagen()
    }

    /* Cambiar la imagen del jugador al moverse hacia la izquierda */
    method cambiarImagenAMovimientoIzquierda() {
        image = "juanSalvo/Jugador_V1_Caminar_Derecha_3-176x192.png"
        self.actualizarImagen()
    }

    /* Cambiar la imagen del jugador al disparar */
    method cambiarImagenADisparo() {
        image = arma.juanApuntando()
        self.actualizarImagen()
    }

    /* Revertir la imagen del jugador a la imagen original después de disparar */
    method revertirImagenOriginal() {
        image = arma.juanArmaReposo()
        self.actualizarImagen()
    }

    /* Actualizar la imagen del jugador en el juego */
    method actualizarImagen() {
        game.removeVisual(self)
        game.addVisual(self)
    }

    /* Iniciar un período de espera antes de que el jugador pueda moverse nuevamente */
    method iniciarPeriodoDeEsperaParaMovimiento() {
        puedeMoverse = false
        game.schedule(200, { if (!estaMuerto) puedeMoverse = true })
    }

    override method morir() {
        self.desactivarFuncionalidades()
		const nuevaMuerte = new MuerteJuan(image = image, position = position, nombreTick = "Muerte Juan")
        game.removeVisual(self)
        game.addVisual(nuevaMuerte)
        nuevaMuerte.mostrar()
        game.schedule(1500, { new Reinicio().mostrar() })
    }

    /* Devolver al jugador a la posición inicial */
    method volverAlOrigen() {
        position = game.at(0, 1)
    }
}

/* Clase base para los enemigos del juego */
class Enemigo inherits Personaje(position = game.at(game.width(), [ 1, 3 ].anyOne())) {
	const property danio
	const property puntosOtorgadosPorMuerte
	const property id = self.identity().toString()

	/* Crear y agregar el enemigo al juego */
	method crear() {
		position = self.position()
		game.addVisual(self)
		self.movimiento()
	}

	/* Desplazar al enemigo hacia la izquierda */
	method desplazarse() {
		if (position.x() < -2) self.desactivarFuncionalidades() else position = position.left(1)
	}

	/* Eliminar al enemigo del juego */
	override method desactivarFuncionalidades() {
		game.removeTickEvent(id + "_movimiento")
		game.removeTickEvent(id + "_cambiarImagen")
		self.morir()
	}

	/* Manejar el impacto de un objeto con el enemigo */
	override method serImpactado(objeto) {
		vida = 0.max(vida - objeto.danio())
		objeto.serImpactado(self)
	}
	
	override method sumarPuntosPorMuerte() {
		if (vida == 0) {
			self.desactivarFuncionalidades()
			puntuacion.sumarPuntos(self)
		}
	}
	
	/* Método vacío para ser sobrescrito por subclases */
	method movimiento()
}

/* Clase Cascarudo que hereda de Enemigo */
class Cascarudo inherits Enemigo(image = "cascarudo/Cascarudo_Base_Izquierda-176x176.png",
	 vida = 200,
	 danio = 50,
	 puntosOtorgadosPorMuerte = 50) {
	
	const property animacion = new CascarudoCaminando(image = self.image(), position = self.position())
	var property tiempoCreacion = 1000
	
	/* Generar enemigos Cascarudo periódicamente */
	method generarEnemigos() {
		game.onTick(tiempoCreacion, "generar_cascarudos", { const nuevoCascarudo = new Cascarudo()
			nuevoCascarudo.crear()
		})
	}
	/* Movimiento del Cascarudo */
    override method movimiento() {
        game.onTick(150, id + "_movimiento", { self.desplazarse() })
        game.onTick(400, id + "_cambiarImagen", { self.cambiarImagen() })
    }

    /* Cambiar la imagen del Cascarudo */
    method cambiarImagen() {
        animacion.cambiarImagen()
        image = animacion.image()
    }

	override method morir() {
		estaMuerto = true
		const nuevaMuerte = new MuerteCascarudo(image = self.image(), position = self.position(), nombreTick = self.id() + "Muerte Cascarudo")
		game.removeVisual(self)
		game.addVisual(nuevaMuerte)
		nuevaMuerte.mostrar()
	}
}

/* Clase HombreRobot que hereda de Enemigo */
class HombreRobot inherits Enemigo(image = "hombresRobots/Hombre_Robot_Base-272x192.png",
	vida = 100,
	danio = 10,
	puntosOtorgadosPorMuerte = 50) {
	   		
	 const property animacion = new HombreRobotCaminando(image = self.image(), position = self.position())

	/* Sobrescribir el método crear para incluir la acción de disparo */
	override method crear() {
		super()
		self.accionarArma()
	}

	/* Generar enemigos HombreRobot periódicamente */
	method generarEnemigos() {
		game.onTick(2000, "generar_hombres_robots", { const nuevoHombreRobot = new HombreRobot()
			nuevoHombreRobot.crear()
		})
	}
	
/* 	/* Cambiar la imagen del Cascarudo */
     method cambiarImagen() {
        animacion.cambiarImagen()
        image = animacion.image()
    }
    
    /* Movimiento del HombreRobot */
	override method movimiento() {
		game.onTick((600..900).anyOne(), id + "_movimiento", { self.desplazarse()})
		game.onTick(400, id + "_cambiarImagen", { self.cambiarImagen()})
	}
    
	/* Acción de disparo del HombreRobot */
	method accionarArma() {
		game.onTick(2500, id + "_disparar", { const bala = new MunicionHombreRobot(position = game.at(self.position().x() - 1, self.position().y()))
			self.cambiarImagenADisparo()
			bala.salirDisparada()
			self.cambiarImagenADisparo()
			game.schedule(100, {if (!estaMuerto) self.revertirImagenOriginal()})
		})
	}

	override method morir() {
		estaMuerto = true
		const nuevaMuerte = new MuerteHombreRobot(image = self.image(), position = self.position(), nombreTick = self.id() + "Muerte Hombre Robot")
		game.removeVisual(self)
		game.addVisual(nuevaMuerte)
		nuevaMuerte.mostrar()
	}

	/* Eliminar al HombreRobot del juego */
	override method desactivarFuncionalidades() {
		game.removeTickEvent(id + "_disparar")
		super()
	}

	/* Cambiar la imagen del HombreRobot al disparar */
	method cambiarImagenADisparo() {
		image = "hombresRobots/Hombre_Robot_Disparar-272x192.png"
		game.removeVisual(self)
		game.addVisual(self)
	}

	/* Revertir la imagen del HombreRobot a la posición original */
	method revertirImagenOriginal() {
		image = "hombresRobots/Hombre_Robot_Base-272x192.png"
		game.removeVisual(self)
		game.addVisual(self)
	}
}

object mano inherits Personaje(position = game.at(17, 2), image = "Mano.png", vida = vidaEscudoRayo.vida()) {

	var property tiempoAtaque = 1700
	const property armaTerrenal = [ rayo1, rayo2 ]
	const property armaAerea = nave
	const property puntosOtorgadosPorMuerte = 1000

	method accionarArma() {
		if(vidaEscudoRayo.vida() >= 10)
		game.onTick(tiempoAtaque, "Mano ataque", { armaAerea.atacar()
			armaTerrenal.forEach({ r => r.atacar()})
		})
	}
	
	override method desactivarFuncionalidades() {
		game.removeTickEvent("Mano ataque")
	}
	
	override method morir(){
		image = "explosion.png"
		game.removeVisual(self)
		game.addVisual(self)
	}
}
