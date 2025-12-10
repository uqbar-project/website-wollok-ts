import battlecity.*

object gestion_menues {

    method cambiar_fondo_y_opciones(nuevaImagen_menu, opciones) {

        game.addVisual(imagen_menu_del_juego)
        imagen_menu_del_juego.image(nuevaImagen_menu)

        self.listar_opciones(opciones)

        game.addVisual(flecha)
        flecha.desplazarFlechaPorLasOpciones(opciones)
        flecha.detectarQueOpcionElijo()

    }

    method cambiar_solo_el_fondo(nuevaImagen_menu) {

        game.addVisual(imagen_menu_del_juego)
        imagen_menu_del_juego.image(nuevaImagen_menu)
    }


    method listar_opciones (opciones) {

        opciones.forEach({unaOpcion => game.addVisual(unaOpcion)})
    }
}

object imagen_menu_del_juego {

    const position = new Position()
    var imagenDelMenu = "menu_inicial.png"

    method image() {
        return imagenDelMenu
    }

    method image(nuevaImagen) {
        imagenDelMenu = nuevaImagen
    }

    method position() {
        return position
    }
}

object flecha {

    var position = new Position(x = 5, y = 7)
    var opcionSelecionada = nada

    method image() {
        return "flecha_juego.png"
    }

    method position() {
        return position
    }

    method position(nuevaPosicion) {
        position = nuevaPosicion
    }

    method desplazarFlechaPorLasOpciones(opciones) {
        keyboard.up().onPressDo {
            const nuevaPosicion = position.up(2)

            if (nuevaPosicion.y() <= opciones.head().position().y() ) self.position(nuevaPosicion)
        }

        keyboard.down().onPressDo {
            const nuevaPosicion = position.down(2)

            if (nuevaPosicion.y() >= opciones.last().position().y() ) self.position(nuevaPosicion)
        }

        keyboard.enter().onPressDo {
            opcionSelecionada.ejecutar()
            self.position(new Position (x = 5, y = 7))
        }
    }

    method detectarQueOpcionElijo() {
        game.onCollideDo(self, {opcion => opcionSelecionada = opcion})
    }

    method opcionSelecionada() = opcionSelecionada
}

class Opciones_De_Menu {

    const posicion
    const texto_nombre_de_opcion

    method position() {
        return posicion
    }

    method image() {
        return texto_nombre_de_opcion
    }

    method retrocederAEsteMenuDinamico(menu, opciones) 
    {
        keyboard.backspace().onPressDo(
        {    
            game.clear()
            gestion_menues.cambiar_fondo_y_opciones(menu, opciones)
        })
    }

    method retrocederAEsteMenuEstatico(menu) 
    {
        keyboard.backspace().onPressDo(
        {    
            game.clear()
            gestion_menues.cambiar_solo_el_fondo(menu)
        })
    }
}

object modo_versus inherits Opciones_De_Menu (posicion = new Position (x = 5, y = 7 ), texto_nombre_de_opcion = "logo_de_modo_versus.png" ) {

    method ejecutar() {

        game.clear()

        gestion_menues.cambiar_fondo_y_opciones("menu_inicial.png", niveles)
        game.addVisual(visualizacion_mapa)

        self.retrocederAEsteMenuDinamico("menu_inicial.png", jugabilidades)

    }
}

object como_se_juega inherits Opciones_De_Menu (posicion = new Position (x = 5, y = 5), texto_nombre_de_opcion = "logo_como_jugar.png") {

    method ejecutar() {

        game.clear()

        gestion_menues.cambiar_solo_el_fondo("menu_como_jugar.png")

        self.retrocederAEsteMenuDinamico("menu_inicial.png", jugabilidades)
    }
}

object visualizacion_mapa {

    const position = new Position(x = 1, y = 4)

    method image() {
        const nivelQueApunta = flecha.opcionSelecionada()
        return nivelQueApunta.visualizacion_previa()
    }

    method position() {
        return position
    }
}

object nada {

    method visionPrevia() {
        return "flecha_juego.png"
    }
}