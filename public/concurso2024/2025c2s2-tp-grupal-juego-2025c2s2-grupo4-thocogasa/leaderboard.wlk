import wollok.game.*
import UI.*

object leaderboard {
  const entries = []         // { name, score }
  const displayed = []
  var property maxEntries = 3
  var property visible = false

  method addEntry(name, valor) {
    const entry = new LeaderboardEntry(name = name, value = valor)
    entries.add(entry)
  }

  method addCurrentScoreWithName(name) {
    self.addEntry(name, score.valor())
  }

  method top(n) {
    const result = []
    const desired = if (n > entries.size()) entries.size() else n
    desired.times({ _ =>
      var best = null
      entries.forEach({ e =>
        if (not result.contains(e)) {
          if (best == null or e.value() > best.value()) best = e
        }
      })
      if (best != null) result.add(best)
    })
    return result
  }

  method clear() { entries.clear() }

  method show() {
    displayed.forEach({ d => if (game.hasVisual(d)) game.removeVisual(d) })
    displayed.clear()
    const topEntries = self.top(maxEntries).reverse()
    var row = 1 + (topEntries.size() - 1)
    topEntries.forEach({ e =>
      const line = new LeaderboardEntry(
        name = e.name(),
        value = e.value(),
        position = game.at(5, row)
      )
      displayed.add(line)
      game.addVisual(line)
      row = row - 1
    })
  }

  method hide() {
    displayed.forEach({ d => if (game.hasVisual(d)) game.removeVisual(d) })
    displayed.clear()
  }

  method toggle() {
    visible = not visible
    if (visible) self.show() else self.hide()
  }
}

class LeaderboardEntry {
  var property name = "Anon"
  var property value = 0
  var property position = game.at(5, 2)
  method text() = self.name() + " " + self.value()
  method textColor() = "000000ff"
}