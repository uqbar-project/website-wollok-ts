import models_game.*

class Tower {
  var property position
  const power
  const attackSpeed
  const range
  const attack
  const cost
  const image
  var text = ""
  var status = "idle"
  const attackTick = game.tick(500, { self.attackInRange() }, true)
  var attackInCooldown = false
  
  method image() = ((image + "_") + status) + ".png"

  method text() = text

  method textColor() = "004e01"
  
  method cost() = cost

  method sellPrice() = cost / 2
  
  method power() = power
  
  method range() = range

  method attackSpeed() = attackSpeed

  method attackInCooldown() = attackInCooldown

  method spawn() {
    game.addVisual(self)
    game.sound("sfx_tower_spawn.mp3").play()
    attackTick.start()
  }
  
  method despawn() {
    game.removeVisual(self)
    attackTick.stop()
  }

  method attackInRange() {
    if (self.canAttack()){
      self.attackEnemy(self.enemyToAttack(self.enemiesInRange(tdGame.enemiesInPlay())))
    }
  }

  method canAttack() = !attackInCooldown

  method attackEnemy(enemy) {
    if (enemy != null) {
      self.putAttackInCooldown()
      self.triggerAttackAnimation()
      attack.doAttack(power, enemy)
    }
  }

  method putAttackInCooldown() {
    attackInCooldown = true
    game.schedule(attackSpeed-100, {attackInCooldown = false})
  }
  
  
  method status(newStatus) {
    status = newStatus
  }
  
  method triggerAttackAnimation() {
    self.status("attacking")
    game.schedule(250, { self.status("idle") })
  }
  
  method enemyToAttack(enemies) {
    if (enemies.isEmpty()) return null
    return enemies.max({enemy => enemy.pathIndex()})
  }
  
  method enemiesInRange(enemies) = enemies.filter(
    { enemy => self.isInRange(enemy) }
  )
  
  method isInRange(enemy) = position.distance(enemy.position()) <= range
  
  method cloneInPosition(newPosition) = new Tower(
    position = newPosition,
    power = power,
    attackSpeed = attackSpeed,
    range = range,
    attack = attack,
    cost = cost,
    image = image
  )

  method checkCollide() {
    if (position == player.position()) text = "$" + self.sellPrice().toString()
    else text = ""
  }
}

object basicAttack {
  method doAttack(damage, enemy) {
    enemy.receiveBasicAttack(damage)
  }
}

object piercingAttack {
  method doAttack(damage, enemy) {
    enemy.receivePiercingAttack(damage)
  }
}

object slowingAttack {
  method doAttack(damage, enemy) {
    enemy.receiveSlowingAttack(damage)
  }
}

const basicTower = new Tower(
  position = game.at(99,99),
  power = 1,
  attackSpeed = 1500,
  range = 3,
  attack = basicAttack,
  cost = 50,
  image = "tower_basic"
)

const piercingTower = new Tower(
  position = game.at(99,99),
  attack = piercingAttack,
  power = 1,
  cost = 100,
  range = 2,
  attackSpeed = 2000,
  image = "tower_piercing"
)

const slowingTower = new Tower(
  position = game.at(99,99),
  attack = slowingAttack,
  power = 0,
  cost = 150,
  range = 2,
  attackSpeed = 2500,
  image = "tower_slowing"
)