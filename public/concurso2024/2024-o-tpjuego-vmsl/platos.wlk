/*
object vacio {
  method imagenDialogo() = "vacioDialogo.png"
}*/

class Comida {
  var property puntaje
  var property position
  var property image
  
  method imagenDialogo()
}

// Agregar power ups para cada comida
class Pasta inherits Comida (image = "pasta.png") {
  override method imagenDialogo() = "dialogoPast.png"
}

class Sandwich inherits Comida (image = "sandwich4.png") {
  override method imagenDialogo() = "dialogoSandw.png"
}

class Ensalada inherits Comida (image = "ensalada1.png") {
  override method imagenDialogo() = "dialogoEns.png"
}

class Waffle inherits Comida (image = "waffles1.png") {
  override method imagenDialogo() = "dialogoWaff.png"
}

const pasta = new Pasta(puntaje = 10, position = game.at(9, 1))

const sandwich = new Sandwich(puntaje = 8, position = game.at(12, 1))

const ensalada = new Ensalada(puntaje = 12, position = game.at(14.5, 1))

const waffle = new Waffle(puntaje = 11, position = game.at(17.5, 1))

const comidas = [pasta, sandwich, ensalada, waffle]

class Relleno {
  var property image
  var property position
}

const bandeja1 = new Relleno(position = game.at(1, 0.5), image = "bandeja1.png")

const bandeja2 = new Relleno(position = game.at(2, 0.5), image = "bandeja2.png")

const menu2 = new Relleno(position = game.at(3, 1), image = "menu3.png")

const cafes = new Relleno(position = game.at(5, 1), image = "platoCafe.png")

const platillos = new Relleno(
  position = game.at(21, 1),
  image = "platillo1.png"
)

const menu = new Relleno(position = game.at(27, 0.5), image = "menu1.png")

const maquinaCafe = new Relleno(
  position = game.at(28, 0.5),
  image = "maqcafe.png"
)

const platosVacios = new Relleno(
  position = game.at(26, 0.5),
  image = "platos.png"
)

const rellenos = [
  menu,
  maquinaCafe,
  platosVacios,
  bandeja1,
  bandeja2,
  menu2,
  platillos,
  cafes
]