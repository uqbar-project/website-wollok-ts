// ===============================
// Revisado
// ===============================

import game.*
import proyectil.*
// ===============================
// Administrador de Proyectiles: Controla la creación y gestión de proyectiles
// ===============================
class MiException inherits wollok.lang.Exception {}
object administradorDeProyectiles {
    // Propiedades
    var nombreProyectil = 20000 // Identificador único para cada proyectil creado
    var property proyectiles = #{} // Almacena los proyectiles creados

    method nombre() = nombreProyectil // Obtiene el último nombre usado

    // Incrementa el contador de nombreProyectil para nombrar proyectiles de manera única
    method sumarProyectil() { nombreProyectil += 1 }

    // Genera un nuevo proyectil en la posición y tipo especificado
    method generarProyectil(posicion, tipoProyectil) {
        var nombreParaProyectil = self.nombre()
        nombreParaProyectil = new Proyectil(position = posicion, tipoProyectil = tipoProyectil)
        proyectiles.add(nombreParaProyectil)
        self.sumarProyectil()
        game.addVisual(nombreParaProyectil)
        nombreParaProyectil.combinar()
        try nombreParaProyectil.colisionar() catch e "YA NO EXISTE PROYECTIL"
    }

    // Mueve cada proyectil en la lista
    method moverProyectiles() {
        proyectiles.forEach({ proyectil => proyectil.mover() })
    }

    // Activa la colisión para cada proyectil en la lista
    method impactarProyectiles() {
        proyectiles.forEach({ proyectil => proyectil.colisionar() })
    }

    method combinarProyectiles() {
        proyectiles.forEach({ proyectil => proyectil.combinar() })
    }

    // Elimina un proyectil de la lista
    method destruirProyectil(proyectil) {
        proyectiles.remove(proyectil)
    }
    method cambiarFrame(){
        proyectiles.forEach({proyectil=> proyectil.cambiarFrame()})
    }
    // Restablece el administrador, eliminando todos los proyectiles y reiniciando el contador de nombres
    method reset() {
        proyectiles.forEach({ proyectil => proyectil.eliminar() })
        nombreProyectil = 0
        proyectiles = []
    }
}
