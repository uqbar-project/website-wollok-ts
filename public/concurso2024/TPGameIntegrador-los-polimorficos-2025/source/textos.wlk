import objetos.*
import wollok.game.*

class TextosInfo {
  const property texto
  const property color
  const property position 

  method text() = texto
  method textColor() = color
  method position() = position
}


object color {
  const property blanco = "#ffffff"
  const property rojo = "#ff0000"
  const property amarillo = "#ffff00"
}
const casaCachito =              new TextosInfo(texto ="               Estas en: Casa de Cachito",             color =color.blanco(), position = game.at(8,15))
const teroViolado =              new TextosInfo(texto ="               Estas en: Tero Violado",             color =color.blanco(), position = game.at(8,15))
const iglesiaTeroViolado =       new TextosInfo(texto ="      Estas en: Iglesia de Tero Violado",             color =color.blanco(), position = game.at(8,15))
const ovniAlien =                new TextosInfo(texto ="          Estas en: zona de aterrizaje del ovni",             color =color.blanco(), position = game.at(7,0)) 
const costaNahuelito =           new TextosInfo(texto ="      Estas en: Lago Salinas del Ambargasta",             color =color.blanco(), position = game.at(8,15))
const zonaLuzMala =           new TextosInfo(texto ="         Estas en: Zona de luz Mala",             color =color.blanco(), position = game.at(8,15))
const none =                  new TextosInfo(texto ="", color =color.blanco(), position = game.at(0,0))
