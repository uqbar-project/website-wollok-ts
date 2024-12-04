import configuracion.*
import platos.*
import clientes.*
import mueblesMapa.*
import mozo.*

object distancia{

    // Verifica movimiento dentro de los limites del juego
    method dentroDeLimites(direccion) = direccion.x() >= 1 && direccion.x() < game.width() - 1 
                                    && direccion.y() >= 1 && direccion.y() < game.height() - 1

    //encuentra el plato mas cercano, con un distancia de 1 celda
    method platoCercano() = comidas.findOrElse(
    { plato => mozo.position().distance(plato.position()) <= 1 },
    { null }
  )

    //encuentra la mesa mas cercana, con un distancia de 2 celdas o menos
    method mesaCercana() = mesas.findOrElse(
    { mesa => mesa.estaOcupada() && (mozo.position().distance(
        mesa.position()
      ) <= 2) },
    { null }
  ) // Hacer mas declarativa esta funcion
}