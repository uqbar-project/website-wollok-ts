import game.*
import slime.*
import administradorDeOleadas.*


/* =======================================
   Administrador de Enemigos: Gestión de enemigos en el juego
   ======================================= */
object administradorDeEnemigos {
    // constantes
    const maxEnemigosEnPantalla = 8
    // Propiedades
    var nombreEnemigo = 10000
    var enemigos = #{}
   
    // Métodos de Consulta
    method enemigos() = enemigos
    method columnaOcupada() = enemigos.filter({ enemigo => enemigo.position().x() == 14 }).size() == 5 // Verifica si la columna de posición x=14 está ocupada por 5 enemigos
    method nombre() = nombreEnemigo
    method pocosEnemigosEnPantalla() = administradorDeOleadas.enemigosVivos() < maxEnemigosEnPantalla

    // Genera un nuevo nombre para los enemigos
    method sumarEnemigo() { nombreEnemigo += 1 }

    // Genera un nuevo enemigo del tipo especificado, si hay espacio en la columna 
    method generarEnemigo(tipo) {
        if (not self.columnaOcupada() && self.pocosEnemigosEnPantalla()) {
            const posicionTemporal = new MutablePosition(x = 14, y = 0.randomUpTo(5).truncate(0))
            var nombreParaEnemigo = self.nombre() 

            /* Solo genera el enemigo si la posición temporal está vacía */
            if (game.getObjectsIn(posicionTemporal).isEmpty()) {
                
                nombreParaEnemigo = new Slime(position = posicionTemporal, tipo = tipo)
                enemigos.add(nombreParaEnemigo) /* Añade el nuevo enemigo a la colección de enemigos activos */
                
                self.sumarEnemigo() /* Incrementa el contador de enemigos en el administrador */
                administradorDeOleadas.sumarEnemigo() /* Notifica al administrador de oleadas */
                
                return game.addVisual(nombreParaEnemigo) /* Muestra al enemigo en el juego */
            } else {
                return /* No genera el enemigo si la posición está ocupada */
            }
        }
    }

    // Elimina un enemigo específico de la colección de enemigos activos
    method eliminarEnemigo(enemigo) {
        administradorDeOleadas.reducirEnemigo()
        enemigos.remove(enemigo)
    }

    // Resetea el estado del administrador, eliminando todos los enemigos y reiniciando el contador
    method reset() {
        enemigos.forEach({ enemigo => enemigo.eliminar() })
        nombreEnemigo = 0
        enemigos = []
    }

    // Verifica si los enemigos están muertos
    method estanMuertos() {
        enemigos.forEach({ enemigo => enemigo.estaMuerto() })
    }

    // Ordena a cada enemigo ejecutar la función de movimiento
    method moverEnemigos() {
        enemigos.forEach({ enemigo => enemigo.movete() })
    }
    method cambiarFrame(){
        enemigos.forEach({ enemigo => enemigo.cambiarFrame()})
    }
}
