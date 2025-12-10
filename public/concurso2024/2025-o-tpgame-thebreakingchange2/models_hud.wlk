import models_towers.*
import models_game.*

class HudTile {
  var property position
  const hudPosition
  
  method image() = ("hud_bg_" + hudPosition) + ".png"
}

object hud {
  const hudTiles = []
  
  method setupHudTiles() {
    hudTiles.add(
      new HudTile(position = game.at(18, 0), hudPosition = "bottom_left")
    )
    hudTiles.add(
      new HudTile(position = game.at(18, 13), hudPosition = "top_left")
    )
    hudTiles.add(
      new HudTile(position = game.at(22, 0), hudPosition = "bottom_right")
    )
    hudTiles.add(
      new HudTile(position = game.at(22, 13), hudPosition = "top_right")
    )
    
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].forEach(
      { y => hudTiles.add(
          new HudTile(position = game.at(18, y), hudPosition = "left")
        ) }
    )
    
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].forEach(
      { y => hudTiles.add(
          new HudTile(position = game.at(22, y), hudPosition = "right")
        ) }
    )
    
    [19, 20, 21].forEach(
      { x => hudTiles.add(
          new HudTile(position = game.at(x, 0), hudPosition = "bottom")
        ) }
    )
    [19, 20, 21].forEach(
      { x => hudTiles.add(
          new HudTile(position = game.at(x, 13), hudPosition = "top")
        ) }
    )
    
    [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12].forEach(
      { y => [19, 20, 21].forEach(
          { x => hudTiles.add(
              new HudTile(position = game.at(x, y), hudPosition = "center")
            ) }
        ) }
    )
  }
  
  method beDisplayed() {
    self.setupHudTiles()
    self.displayHudBackground()
    game.addVisual(gameTitle)
    game.addVisual(stageProgressVisualizer)
    game.addVisual(enemiesRemainingVisualizer)
    game.addVisual(resourcesVisualizer)
    game.addVisual(hpVisualizer)
    basicTowerVisualizer.beDisplayed()
    piercingTowerVisualizer.beDisplayed()
    slowingTowerVisualizer.beDisplayed()
    game.addVisual(controlsTooltip)
  }
  
  method displayHudBackground() {
    if (!optimized_mode) hudTiles.forEach({ tile => game.addVisual(tile) })
  }

  method limit() = hudTiles.get(0).position().x() - 1
}

object gameTitle {
  const property position = game.at(19, 12)
  
  method image() = "hud_game_title.png"
}

object stageProgressVisualizer {
  const property position = game.at(19, 10)
  
  method text() = "🚩 " + tdGame.roundsRemaining().toString()
  
  method textColor() = "FFFFFFFF"
}

object enemiesRemainingVisualizer {
  const property position = game.at(21, 10)
  
  method text() = "💀 " + tdGame.enemiesRemaining().toString()
  
  method textColor() = "FFFFFFFF"
}

object hpVisualizer {
  const property position = game.at(19, 9)
  
  method text() = "❤️ " + tdGame.hp().toString()
  
  method textColor() = "FFFFFFFF"
}

object resourcesVisualizer {
  const property position = game.at(21, 9)
  
  method text() = "🪙 " + tdGame.resources().toString()
  
  method textColor() = "FFFFFFFF"
}

class TowerSpecsVisualizer {
  const startingPosition
  const tower
  const buttonToPlace
  const towerImage = new TowerImage(
    position = startingPosition,
    tower = tower,
    buttonToPlace = buttonToPlace
  )
  const towerSpecs = new TowerSpecs(
    position = game.at(startingPosition.x(), startingPosition.y() - 1),
    tower = tower
  )
  
  method beDisplayed() {
    game.addVisual(towerImage)
    game.addVisual(towerSpecs)
  }
  
  method towerSpecsString() = ""
}

class TowerImage {
  const property position
  const tower
  const buttonToPlace
  
  method image() = tower.image()
  
  method text() = buttonToPlace
  
  method textColor() = "000000ff"
}

class TowerSpecs {
  const property position
  const tower
  
  method text() = (((("🪙 " + tower.cost().toString()) + " | ⚔️ ") + tower.power().toString()) + " | 🎯 ") + tower.range().toString() + " | ⚡ " + tower.attackSpeed() / 1000 + " sec"
  
  method textColor() = "FFFFFFFF"
}

const basicTowerVisualizer = new TowerSpecsVisualizer(
  startingPosition = game.at(20, 7),
  buttonToPlace = "1️⃣",
  tower = basicTower
)

const piercingTowerVisualizer = new TowerSpecsVisualizer(
  startingPosition = game.at(20, 5),
  buttonToPlace = "2️⃣",
  tower = piercingTower
)

const slowingTowerVisualizer = new TowerSpecsVisualizer(
  startingPosition = game.at(20, 3),
  buttonToPlace = "3️⃣",
  tower = slowingTower
)

class EndGameScreen {
   var property position = game.at(0,0)
    const sound
    const image

     method image() = image

    method beDisplayed(){
    game.addVisual(self)
    sound.play()
  }

  method beRemoved(){
    game.removeVisual(self)
    if (sound.played()) sound.stop()
  }
}

const gameOverScreen = new EndGameScreen(sound = game.sound("sfx_gameover.wav"), image = "screen_gameover_impact.png")
const victoryScreen = new EndGameScreen(sound = game.sound("sfx_win.wav"), image = "screen_victory.png")


object controlsTooltip {
  const property position = game.at(20, 1)
  
  method text() = "R: Reset Game\nE: Start round\nQ: Tower Selection Mode\nSpace: Place Tower\n X: Sell Tower"
  method textColor() = "FFFFFFFF"


}
