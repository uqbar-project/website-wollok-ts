import wollok.game.*
import rey.*
import aliados.*
import mecanicas.*
import enemigo.*
import images.*

class PeonEnemigo inherits Enemigo (valor = 10, imagePieza = images.peonNegro()) {
  override method posicionesAvanzables() = [self.position().down(1)]
  override method posicionesCapturables() = []
}

class AlfilNegro inherits Enemigo (valor = 30, imagePieza = images.alfilNegro()) {
  override method posicionesAvanzables() = [self.position().right(1).down(1), self.position().left(1).down(1)]
}

class CaballoNegro inherits Enemigo (valor = 50, imagePieza = images.caballoNegro()) {
  override method posicionesAvanzables() = [
    self.position().right(1).down(2), 
    self.position().left(1).down(2),
    self.position().right(2).down(1),
    self.position().left(2).down(1)]
}

class TorreNegro inherits Enemigo (valor = 50, imagePieza = images.torreNegro()) {
  override method posicionesAvanzables() = [self.position().down(1)]
  override method posicionesCapturables() = [game.at(0, self.position().y()), game.at(1, self.position().y()), game.at(2, self.position().y()), game.at(3, self.position().y()), game.at(4, self.position().y())]
}

class DamaNegro inherits AlfilNegro (valor = 200, imagePieza = images.damaNegro()) {}