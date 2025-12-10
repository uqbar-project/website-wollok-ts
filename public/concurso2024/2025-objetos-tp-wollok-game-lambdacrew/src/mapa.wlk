import src.battlecity.*
import muro.*
import tanque_enemigo.*
import tanque.*
import halcon.*
import base.*
import menus.*

const inicio_batalla = game.sound("inicio_partida.mp3")

object gestion_niveles {

  method regenerar_nivel(nivelARegenerar)
  {
    
    nivelARegenerar.reHacerMuros()
    nivelARegenerar.reubicarHalcon()

  }

  method cargar_nivel(nivelACargar) 
  {

    nivelACargar.dibujarMapa()

    game.addVisual(jugador2_tanque)
    game.addVisual(jugador1_tanque)

    nivelACargar.dibujarDetalles()

  }

  method nueva_ronda()
  {
    game.clear()

    const nivelActual = flecha.opcionSelecionada()

    self.regenerar_nivel(nivelActual)
    self.cargar_nivel(nivelActual)

    jugador1_tanque.normalizar()
    jugador2_tanque.normalizar()

    juegoBattleCity.configurar()

  } 
}

class Mapa {

    const visualizacion_previa

    const nombre_nivel

    const ubicacion_en_pantalla_de_seleccion

    const muros
    const arbustos
    const parches_de_agua
    const halcones
    const bases

    method visualizacion_previa() {
        return visualizacion_previa
    }

    method image() {
        return nombre_nivel
    }

    method position() {
        return ubicacion_en_pantalla_de_seleccion
    }

    method ejecutar () {

        game.clear()

        game.schedule(500, {inicio_batalla.play()})

        gestion_niveles.cargar_nivel(self)
        gestion_niveles.regenerar_nivel(self)

        juegoBattleCity.configurar()

    }

    method detenerMusica() {

        game.sound("inicio_partida.mp3").stop()

    }

    method dibujarMapa() {
        muros.forEach({n => game.addVisual(n)})
        parches_de_agua.forEach({n => game.addVisual(n)})
        halcones.forEach({n => game.addVisual(n)})
        bases.forEach({n => game.addVisual(n)})
    }

    method dibujarDetalles(){
        arbustos.forEach({n => n.dibujarMuro()})
    }

    method setearInicioTanqueEnElMapa (posicionInicial_jugador1, posicionInicial_jugador2) {
        jugador1_tanque.position(posicionInicial_jugador1)
        jugador1_tanque.setearSpawn()
        jugador2_tanque.position(posicionInicial_jugador2)
        jugador2_tanque.setearSpawn()

    }

    method reHacerMuros() {
        muros.forEach({n => n.restablecerDurabilidad()})
    }

    method reubicarHalcon() {
        halcones.forEach({n => n.restablecerUbicacion() n.liberada()})
    }



    
}
object nivel1 inherits Mapa ( 
    visualizacion_previa = "nivel1_previsualizacion.png", 
    ubicacion_en_pantalla_de_seleccion = new Position (x = 5, y = 7),
    nombre_nivel = "campo_batalla_1.png",

    muros = [
          new Muro_Ladrillos(position = new Position(x = 0, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 2, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 2, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 2, y = 1))


        , new Muro_Ladrillos(position = new Position(x = 8, y = 9))
        , new Muro_Ladrillos(position = new Position(x = 8, y = 8))
        , new Muro_Ladrillos(position = new Position(x = 8, y = 7))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 7))
        , new Muro_Ladrillos(position = new Position(x = 10, y = 7))

        , new Muro_Ladrillos(position = new Position(x = 0, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 0, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 10, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 10, y = 4))

        , new Muro_Ladrillos(position = new Position(x = 5, y = 9))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 8))
        , new Muro_Reforzado(position = new Position(x = 5, y = 6))
        , new Muro_Reforzado(position = new Position(x = 5, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 0))

        , new Muro_Reforzado(position = new Position(x = 2, y = 8))
        , new Muro_Reforzado(position = new Position(x = 1, y = 8))
        , new Muro_Reforzado(position = new Position(x = 2, y = 7))
        , new Muro_Reforzado(position = new Position(x = 1, y = 7))

        , new Muro_Reforzado(position = new Position(x = 9, y = 1))
        , new Muro_Reforzado(position = new Position(x = 8, y = 1))
        , new Muro_Reforzado(position = new Position(x = 9, y = 2))
        , new Muro_Reforzado(position = new Position(x = 8, y = 2))
        ],


    
    arbustos = [ 
          new Arbustos(position = new Position(x = 2, y = 5))
        , new Arbustos(position = new Position(x = 3, y = 5))
        , new Arbustos(position = new Position(x = 2, y = 4))
        , new Arbustos(position = new Position(x = 3, y = 4))
        , new Arbustos(position = new Position(x = 7, y = 5))
        , new Arbustos(position = new Position(x = 8, y = 5))
        , new Arbustos(position = new Position(x = 7, y = 4))
        , new Arbustos(position = new Position(x = 8, y = 4))
        ],

    parches_de_agua = [
          new Parche_De_Agua (position = new Position (x = 4 ,y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 5 ,y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 6 ,y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 4 ,y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 5 ,y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 6 ,y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 5 ,y = 7 ))
        , new Parche_De_Agua (position = new Position (x = 5 ,y = 2 ))
        ],


    halcones = [
          new Halcon (sprite_bandera = "halcon_P1.png", lePerteneceA = jugador1_tanque, origen_bandera = new Position(x = 0, y = 0), posicion = new Position (x = 0, y = 0))
        , new Halcon (sprite_bandera = "halcon_P2.png", lePerteneceA = jugador2_tanque, posicion = new Position(x = 10, y = 9) , origen_bandera = new Position(x = 10, y = 9))
        ],

    bases = [
          new Base(disenio_base = "base_P1.png", lePerteneceA = jugador1_tanque, ubicacion = new Position(x=0,y=1))
        , new Base(disenio_base = "base_P2.png", lePerteneceA = jugador2_tanque, ubicacion = new Position(x=10,y=8))
        ]

    ) {

        override method dibujarMapa() {

            self.setearInicioTanqueEnElMapa(new Position (x = 4, y = 3), new Position (x = 6, y = 6))
            super()
        }
    }

object nivel2 inherits Mapa (
        visualizacion_previa = "nivel2_previsualizacion.png", 
        ubicacion_en_pantalla_de_seleccion = new Position (x = 5, y = 5),
        nombre_nivel = "campo_batalla_2.png", 

        muros = [
          new Muro_Ladrillos(position = new Position(x = 0, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 0, y = 7))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 6))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 7))

        , new Muro_Ladrillos(position = new Position(x = 10, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 10, y = 7))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 6))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 7))

        , new Muro_Ladrillos(position = new Position(x = 2, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 2, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 2, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 3, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 3, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 3, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 4, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 4, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 4, y = 2))

        , new Muro_Ladrillos(position = new Position(x = 5, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 2))

        , new Muro_Ladrillos(position = new Position(x = 6, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 6, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 6, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 7, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 7, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 7, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 8, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 8, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 8, y = 2))
        
        , new Muro_Reforzado(position = new Position(x = 2, y = 8))
        , new Muro_Reforzado(position = new Position(x = 2, y = 9))
        , new Muro_Reforzado(position = new Position(x = 3, y = 5))
        , new Muro_Reforzado(position = new Position(x = 5, y = 1))
        , new Muro_Reforzado(position = new Position(x = 5, y = 3))
        , new Muro_Reforzado(position = new Position(x = 5, y = 5))
        , new Muro_Reforzado(position = new Position(x = 5, y = 7))
        , new Muro_Reforzado(position = new Position(x = 7, y = 5))
        , new Muro_Reforzado(position = new Position(x = 8, y = 8))
        , new Muro_Reforzado(position = new Position(x = 8, y = 9))
        ], 

        arbustos = [
          new Arbustos(position = new Position(x = 2, y = 4))
        , new Arbustos(position = new Position(x = 2, y = 5))
        , new Arbustos(position = new Position(x = 2, y = 6))
        , new Arbustos(position = new Position(x = 3, y = 4))
        , new Arbustos(position = new Position(x = 3, y = 6))
        , new Arbustos(position = new Position(x = 4, y = 3))
        , new Arbustos(position = new Position(x = 4, y = 7))
        , new Arbustos(position = new Position(x = 4, y = 8))

        , new Arbustos(position = new Position(x = 5, y = 8))
        , new Arbustos(position = new Position(x = 6, y = 8))
        , new Arbustos(position = new Position(x = 6, y = 7))
        , new Arbustos(position = new Position(x = 6, y = 3))
        , new Arbustos(position = new Position(x = 7, y = 4))
        , new Arbustos(position = new Position(x = 7, y = 6))
        , new Arbustos(position = new Position(x = 8, y = 4))
        , new Arbustos(position = new Position(x = 8, y = 5))
        , new Arbustos(position = new Position(x = 8, y = 6))
        ], 

        halcones = [
          new Halcon (sprite_bandera = "halcon_P1.png", lePerteneceA = jugador1_tanque, origen_bandera = new Position(x = 0, y = 6), posicion = new Position (x = 0, y = 6))
        , new Halcon (sprite_bandera = "halcon_P2.png", lePerteneceA = jugador2_tanque, origen_bandera = new Position(x = 10, y = 6), posicion = new Position(x = 10, y = 6))
        ], 

        bases = [
          new Base(disenio_base = "base_P1.png", lePerteneceA = jugador1_tanque, ubicacion = new Position(x = 0, y = 4))
        , new Base(disenio_base = "base_P2.png", lePerteneceA = jugador2_tanque, ubicacion = new Position(x = 10, y = 4))
        ], 
        
        parches_de_agua = [
          new Parche_De_Agua (position = new Position (x = 4 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 4 , y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 4 , y = 6 ))
        , new Parche_De_Agua (position = new Position (x = 5 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 5 , y = 6 ))
        , new Parche_De_Agua (position = new Position (x = 6 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 6 , y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 6 , y = 6 ))
        ]
        
        ) {

            override method dibujarMapa() {

            self.setearInicioTanqueEnElMapa(new Position (x = 1, y = 1), new Position (x = 9, y = 1))
            super()
        }
        }

object nivel3 inherits Mapa (
        visualizacion_previa = "nivel3_previsualizacion.png", 
        ubicacion_en_pantalla_de_seleccion = new Position (x = 5, y = 3),
        nombre_nivel = "campo_batalla_3.png", 

        muros = [
          new Muro_Ladrillos(position = new Position(x = 0, y = 7))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 7))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 8))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 9))

        , new Muro_Ladrillos(position = new Position(x = 9, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 10, y = 2))

        , new Muro_Ladrillos(position = new Position(x = 1, y = 0))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 1))
        , new Muro_Ladrillos(position = new Position(x = 1, y = 2))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 9))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 8))
        , new Muro_Ladrillos(position = new Position(x = 9, y = 7))

        , new Muro_Ladrillos(position = new Position(x = 4, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 4, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 4, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 4, y = 6))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 5, y = 6))
        , new Muro_Ladrillos(position = new Position(x = 6, y = 3))
        , new Muro_Ladrillos(position = new Position(x = 6, y = 4))
        , new Muro_Ladrillos(position = new Position(x = 6, y = 5))
        , new Muro_Ladrillos(position = new Position(x = 6, y = 6))
        
        , new Muro_Reforzado(position = new Position(x = 0, y = 0))
        , new Muro_Reforzado(position = new Position(x = 0, y = 1))
        , new Muro_Reforzado(position = new Position(x = 0, y = 2))
        , new Muro_Reforzado(position = new Position(x = 0, y = 3))
        , new Muro_Reforzado(position = new Position(x = 0, y = 4))
        , new Muro_Reforzado(position = new Position(x = 0, y = 5))
        , new Muro_Reforzado(position = new Position(x = 0, y = 6))

        , new Muro_Reforzado(position = new Position(x = 10, y = 9))
        , new Muro_Reforzado(position = new Position(x = 10, y = 8))
        , new Muro_Reforzado(position = new Position(x = 10, y = 7))
        , new Muro_Reforzado(position = new Position(x = 10, y = 6))
        , new Muro_Reforzado(position = new Position(x = 10, y = 5))
        , new Muro_Reforzado(position = new Position(x = 10, y = 4))
        , new Muro_Reforzado(position = new Position(x = 10, y = 3))

        , new Muro_Reforzado(position = new Position(x = 2, y = 3))
        , new Muro_Reforzado(position = new Position(x = 2, y = 6))
        , new Muro_Reforzado(position = new Position(x = 8, y = 3))
        , new Muro_Reforzado(position = new Position(x = 8, y = 6))
        ], 

        arbustos = [
          new Arbustos(position = new Position(x = 1, y = 3))
        , new Arbustos(position = new Position(x = 1, y = 6))
        , new Arbustos(position = new Position(x = 3, y = 3))
        , new Arbustos(position = new Position(x = 3, y = 6))
        , new Arbustos(position = new Position(x = 4, y = 2))
        , new Arbustos(position = new Position(x = 4, y = 7))
        , new Arbustos(position = new Position(x = 5, y = 2))
        , new Arbustos(position = new Position(x = 5, y = 7))
        , new Arbustos(position = new Position(x = 6, y = 2))
        , new Arbustos(position = new Position(x = 6, y = 7))
        , new Arbustos(position = new Position(x = 7, y = 3))
        , new Arbustos(position = new Position(x = 7, y = 6))
        , new Arbustos(position = new Position(x = 9, y = 3))
        , new Arbustos(position = new Position(x = 9, y = 6))
        ], 

        halcones = [
          new Halcon (sprite_bandera = "halcon_P1.png", lePerteneceA = jugador1_tanque, origen_bandera = new Position(x = 0, y = 9), posicion = new Position (x = 0, y = 9))
        , new Halcon (sprite_bandera = "halcon_P2.png", lePerteneceA = jugador2_tanque, origen_bandera = new Position(x = 10, y = 0), posicion = new Position(x = 10, y = 0))
        ], 

        bases = [
          new Base(disenio_base = "base_P1.png", lePerteneceA = jugador1_tanque, ubicacion = new Position(x = 0, y = 8))
        , new Base(disenio_base = "base_P2.png", lePerteneceA = jugador2_tanque, ubicacion = new Position(x = 10, y = 1))
        ], 
        
        parches_de_agua = [
          new Parche_De_Agua (position = new Position (x = 1 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 1 , y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 2 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 2 , y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 3 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 3 , y = 5 ))

        , new Parche_De_Agua (position = new Position (x = 7 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 7 , y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 8 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 8 , y = 5 ))
        , new Parche_De_Agua (position = new Position (x = 9 , y = 4 ))
        , new Parche_De_Agua (position = new Position (x = 9 , y = 5 ))
        ]
        
        ) {

            override method dibujarMapa() {

            self.setearInicioTanqueEnElMapa(new Position (x = 7, y = 8), new Position (x = 3, y = 1))
            super()
        }
        }