// ===============================
// Revisado
// ===============================
import magos.*
import wollok.game.*


/* ===============================
   Administrador de Magos: Gestión de los magos en el juego
   =============================== */
object administradorDeMagos {
    var nombreMago = 0 
    const magos = #{}
    var property magoAGenerar = magoPiedraTienda

    // Métodos de Consulta
    method magos() = magos
    method nombre() = nombreMago

    
    // Suma 1 al contador de nombres de mago para crear nuevos nombres.
    method sumarMago() { nombreMago += 1  }

    // Método para generar un nuevo mago sin usar múltiples if anidados
    method generarMago(magoSeleccionado, posicion) { 
        self.magoAGenerar(magoSeleccionado) 
        var nuevoMago = self.nombre() 
        nuevoMago = self.magoAGenerar().generarMago(posicion) 
        magos.add(nuevoMago)
        self.sumarMago()
        return game.addVisual(nuevoMago)
    }
    
    // Elimina un mago específico del conjunto de magos gestionados
    method eliminarMago(mago) {
        magos.remove(mago)
    }

    // Verifica el estado de cada mago para determinar si están muertos 
    method matarMagos() { magos.forEach({ mago => mago.matar() })  }
    //Ordena a cada mago realizar su acción de disparar
    method disparar() { magos.forEach({ mago => mago.disparar() })  }
    
    //Resetea el administrador de magos, eliminando todos los magos y reiniciando el contador de nombres 
    method reset() {
        magos.forEach({ mago => mago.eliminar() })
        nombreMago = 0 
    }
    
}
