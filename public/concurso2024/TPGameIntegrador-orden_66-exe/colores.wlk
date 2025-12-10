import imagenes.*

class Colores inherits Imagen {
  method mostraryOcultar() {
    if (not game.hasVisual(self)) game.addVisual(self)
    game.schedule(1000, { self.ocultar() })
  }
  
  method ocultar() {
    if (game.hasVisual(self)) game.removeVisual(self)
  }
  
  override method position() = game.at(6, 10)
}

const rojo = new Colores(imagen = "rojo.jpg")

const azul = new Colores(imagen = "azul.jpg")

const verde = new Colores(imagen = "verde.jpg")

const amarillo = new Colores(imagen = "amarillo.jpg")

const sinColores = new Colores(imagen = "sinColores.jpg")
