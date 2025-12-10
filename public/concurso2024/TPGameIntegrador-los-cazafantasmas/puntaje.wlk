import wollok.game.*
class Digito { // de aca salen los 4 digitos para el puntaje
    var property position = game.at(27, 15) // Posición
    var property image = ""
}

object puntaje {
    
    // El puntaje se guarda como un número
    var valorActual = 0

    // lo que van a  mostrar las imágenes
    const  millar = new Digito()
    const  centena = new Digito()
    const  decimal = new Digito()
    const  unidad = new Digito()

    
    // Este método lee la variable 'valorActual' y actualiza las 4 IMÁGENES.
    method actualizarImagenes() {

        // Descompone el número en dígitos (ej:123) -- "/" te da las veces que un número entra en otro y el "%" te da el resto
        const val_unidad  = valorActual % 10
        const val_decena  = (valorActual / 10).truncate(0) % 10
        const val_centena = (valorActual / 100).truncate(0) % 10
        const val_mil     = (valorActual / 1000).truncate(0) % 10

        // Asigna las IMÁGENES 
        unidad.image(self.imagenDeValor(0, val_unidad)) 
		decimal.image(self.imagenDeValor(1, val_decena)) 
		centena.image(self.imagenDeValor(2, val_centena)) 
		millar.image(self.imagenDeValor(3, val_mil))
    }

    // Método auxiliar para construir el nombre de la IMAGEN
    method imagenDeValor(posicion, valor) {
        return "posicion" + posicion.toString() + "_num" + valor.toString() + ".png"
    }

    // metodo para llamar desde el archivo niveles(.configurate)

    method iniciarBarraDePuntos(unValor) {
        valorActual= unValor
        self.actualizarImagenes() // Pone las imágenes iniciales

        game.addVisual(millar)
        game.addVisual(centena)
        game.addVisual(decimal)
        game.addVisual(unidad)
    }
    
    // Suma o resta puntos y actualiza las imágenes
    method sumarPuntos(cantidad) {
        valorActual = ((valorActual + cantidad).max(0)).min(9999)  // Limita el puntaje entre 0 y 9999
        self.actualizarImagenes()
    }

    method puntosActuales(){
        return valorActual
    }
 
    // metodo de puntajes segun lo que pase en el juego
    method puntosPocion() {
        // Suma 500 puntos
        return 550
    }

    method puntosNpc() {
        // Suma 1200 puntos
        return 1200
    }

    method puntosTrampa() {
        // Resta 750 puntos
        return -750
    }

    method puntosCazador() {
        // Resta 1000 puntos
        return -1000
    }
}
