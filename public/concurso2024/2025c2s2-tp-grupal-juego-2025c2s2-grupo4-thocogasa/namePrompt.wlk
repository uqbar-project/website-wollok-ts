import mecanicas.*
import wollok.game.*
import UI.*
import leaderboard.*
import trucos.*

object namePrompt {
  var property awaiting = false
  var property currentName = ""
  var property promptVisual = null
  var property handlersRegistered = false
  method ask() {
    currentName = ""
    awaiting = true
    if (promptVisual == null) promptVisual = new NamePromptVisual(textValue = "Escribí tu nombre: ")
    self.updatePrompt()
    if (not game.hasVisual(promptVisual)) game.addVisual(promptVisual)
    if (not handlersRegistered) {
      // Letras a-z
      keyboard.a().onPressDo({ if (awaiting) self.appendChar("a") })
      keyboard.b().onPressDo({ if (awaiting) self.appendChar("b") })
      keyboard.c().onPressDo({ if (awaiting) self.appendChar("c") })
      keyboard.d().onPressDo({ if (awaiting) self.appendChar("d") })
      keyboard.e().onPressDo({ if (awaiting) self.appendChar("e") })
      keyboard.f().onPressDo({ if (awaiting) self.appendChar("f") })
      keyboard.g().onPressDo({ if (awaiting) self.appendChar("g") })
      keyboard.h().onPressDo({ if (awaiting) self.appendChar("h") })
      keyboard.i().onPressDo({ if (awaiting) self.appendChar("i") })
      keyboard.j().onPressDo({ if (awaiting) self.appendChar("j") })
      keyboard.k().onPressDo({ if (awaiting) self.appendChar("k") })
      keyboard.l().onPressDo({ if (awaiting) self.appendChar("l") })
      keyboard.m().onPressDo({ if (awaiting) self.appendChar("m") })
      keyboard.n().onPressDo({ if (awaiting) self.appendChar("n") })
      keyboard.o().onPressDo({ if (awaiting) self.appendChar("o") })
      keyboard.p().onPressDo({ if (awaiting) self.appendChar("p") })
      keyboard.q().onPressDo({ if (awaiting) self.appendChar("q") })
      keyboard.r().onPressDo({ if (awaiting) self.appendChar("r") })
      keyboard.s().onPressDo({ if (awaiting) self.appendChar("s") })
      keyboard.t().onPressDo({ if (awaiting) self.appendChar("t") })
      keyboard.u().onPressDo({ if (awaiting) self.appendChar("u") })
      keyboard.v().onPressDo({ if (awaiting) self.appendChar("v") })
      keyboard.w().onPressDo({ if (awaiting) self.appendChar("w") })
      keyboard.x().onPressDo({ if (awaiting) self.appendChar("x") })
      keyboard.y().onPressDo({ if (awaiting) self.appendChar("y") })
      keyboard.z().onPressDo({ if (awaiting) self.appendChar("z") })
      keyboard.space().onPressDo({ if (awaiting) self.appendChar(" ") })
      keyboard.backspace().onPressDo({ if (awaiting) self.removeLastChar() })
      keyboard.enter().onPressDo({ if (awaiting) self.submit() })
      handlersRegistered = true
    }
  }

  method appendChar(ch) {
    if (self.currentName().length() < 20) {
      currentName = self.currentName() + ch
      self.updatePrompt()
    }
  }

  method removeLastChar() {
    if (self.currentName().length() > 0) {
      currentName = self.currentName().substring(0, self.currentName().length() - 1)
      self.updatePrompt()
    }
  }

  method submit() {
    const name = if (self.currentName().trim().length() > 0) self.currentName() else "Anon"
    trucos.trigger(name)
    awaiting = false
    if (game.hasVisual(promptVisual)) game.removeVisual(promptVisual)
    leaderboard.addCurrentScoreWithName(name)
    mecanicasJuego.reiniciarJuego()
    leaderboard.show()
  }

  method updatePrompt() {
    if (promptVisual != null) promptVisual.textValue("Escribí tu nombre: " + self.currentName())
  }
}

class NamePromptVisual {
  var property textValue = ""
  var property position = game.at(2, 4)
  method text() = self.textValue()
  method textColor() = "FFFF00"

}
