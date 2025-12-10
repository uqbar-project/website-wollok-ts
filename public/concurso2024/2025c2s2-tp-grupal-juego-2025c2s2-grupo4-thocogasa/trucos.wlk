import UI.*
object trucos {

  var property modoDios = false
  var property infinityAmmo = false
  var property sangre = false
  var property lento = false
  var property idclip = false
  var property hardmode = false

  method motherlode() { game.schedule(1000, { => recurso.añadirRecursos(50000) }) }

  method reset() {
    modoDios = false
    infinityAmmo = false
    sangre = false
    lento = false
    idclip = false
    hardmode = false
  }

  method trigger(code) {
    const key = if (code != null) code.toLowerCase() else ""
    if (key == "idfa") { self.infinityAmmo(true) }
    else if (key == "iddqd") { self.modoDios(true) }
    else if (key == "fatality") { self.sangre(true) }
    else if (key == "vainilla") {self.reset()}
    else if (key == "slowpoke") {self.lento(true)}
    else if (key == "reset") {self.reset()}
    else if (key == "motherlode") {self.motherlode()}
    else if (key == "idclip") { self.idclip(true)}
    else if (key == "noclip") { self.idclip(true)}
    else if (key == "inferno") { self.hardmode(true) }
  }
}
 