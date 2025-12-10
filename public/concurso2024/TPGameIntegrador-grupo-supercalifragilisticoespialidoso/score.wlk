import wollok.game.*

object score {
    var property position = game.at(self.posicionX(), 80) // x, y
    var property puntos = 0
    const scoreDigits = []  // Lista de visuales para los dígitos

    method posicionX() {
        var pos = 115 
        const stringPuntos = puntos.toString()
        const digitos = stringPuntos.split("")

        if (puntos == 1) {
            pos = 115
        }
        if (puntos > 1) {
            pos = 113
        }
        if (puntos >= 10) {
            pos = 109
        }
        if (puntos >= 20) {
            pos = 107
        }
        if (puntos >= 100) {
            pos = 101
        }

        return pos
    }

    method sumar() {
        puntos += 1
        self.actualizarScore()
    }

    method reiniciar() {
        puntos = 0
        scoreDigits.forEach({d => game.removeVisual(d)})
        scoreDigits.clear()
    }


    method actualizarScore() {
        // Borrar visuales anteriores
        position = game.at(self.posicionX(), 80) // Actualizar la posición en X según el número de dígitos
        scoreDigits.forEach({d => game.removeVisual(d)})
        scoreDigits.clear()

        // Convertir el número en string y generar imágenes
        const stringPuntos = puntos.toString()
        const digitos = stringPuntos.split("")

        var offsetX = 0

        digitos.forEach({d =>
            if (!d.isEmpty()) {
                const imagen = new DigitScore(imagen = d + ".png", posicion = position.right(offsetX))
                game.addVisual(imagen)
                scoreDigits.add(imagen)
                offsetX += 6 // Separación entre los dígitos
                if (digitos.first() == "1" and puntos < 100) {
                    offsetX = 4 // Espacio extra para el dígito 1
                }
            }
        })
    }

}

class DigitScore{
    const imagen
    const posicion

    method image() = imagen
    method position() = posicion
}   
