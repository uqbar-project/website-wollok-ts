import models_game.*

class Enemy {
    var pathIndex = 0
    var property position = game.at(99, 99)
    var hp
    const power
    var speed
    var movementTick = null
    const name
    var status = "alive"
    var text = ""

    method image() = "enemy_" + name + "_" + status + ".png"

    method text() = text

	method pathIndex() = pathIndex

    method hp() = hp

    method speed() = speed

    method tickMs() = 1000/speed

    method spawn(path) {
        game.addVisual(self)
        movementTick = game.tick(self.tickMs(), {self.goForward(path)}, true)
        movementTick.start()
    }

    method despawn() {
        movementTick.stop()
    	game.removeVisual(self)
	}

    method goForward(path) {
        position = path.get(pathIndex).position()

        if (self.isAtTheEndOfThePath(path)) {
            self.doDamage(tdGame.currentStage())
        }
        
        pathIndex = path.size().min(pathIndex + 1)
    }

    method isAtTheEndOfThePath(path) = path.last().position() == position

    method doDamage(damageable) {
        damageable.receiveDamage(power)
        self.die()
    }

	method receiveDamage(amount) {
		hp -= amount
        if (amount > 0 ) game.sound("sfx_hit_basic.mp3").play()
		if (self.isDead()){
			self.die()
		}
	}

    method receiveBasicAttack(damage){
		self.receiveDamage(damage)
	}

	method receivePiercingAttack(damage){
		self.receiveDamage(damage)
	}

	method receiveSlowingAttack(damage){
		self.receiveDamage(damage)
		self.beSlowed()
	}
    
    method receiveBlowUpDamage(damage){
        self.receiveDamage(damage)
    }

	method beSlowed(){
		game.sound("sfx_hit_slowing.wav").play()
		speed = 0.25.max(speed / 2)
        movementTick.interval(self.tickMs())
        text += "❄️"
	}

    method die() {
        hp = 0
        tdGame.discountEnemy(self)
        movementTick.stop()
        status = "dying"
        game.schedule(1000, {self.despawn()})
        tdGame.spawnBomb()
    }

	method isDead() = hp <= 0

}

class BasicEnemy inherits Enemy(hp = 3, power = 10, speed = 2, name = "basic"){

    override method image() {
    	return "enemy_" + name + "_" + status + "_" + hp + ".png"
    }
    
    method clone() = new BasicEnemy(hp = hp, power = power , speed = speed, name = name)
}

class ArmoredEnemy inherits Enemy(hp = 1, power = 20, speed = 2, name = "armored") {

	override method receiveBasicAttack(damage){
        self.triggerResistAttackAnimation()
		game.sound("sfx_hit_resisted.wav").play()
	}

    method triggerResistAttackAnimation() {
        status = "resisted"
        game.schedule(200, { if (status == "resisted") status = "alive"})
    }

	override method receiveSlowingAttack(damage){
		self.receiveDamage(0)
		self.beSlowed()
	}

    override method receiveBlowUpDamage(damage){
        self.triggerResistAttackAnimation()
		self.receiveDamage(0)
	}

    method clone() = new ArmoredEnemy(hp = hp , power = power, speed = speed, name = name)
}

class ExplosiveEnemy inherits Enemy(hp = 1, power = 50, speed = 2, name = "explosive") {
	const radius = 2
    const aoe = aoe2.cloneWithTiles()
	
  	override method receivePiercingAttack(damage){
		self.blowUp()
	}

	override method receiveBlowUpDamage(damage){
		self.blowUp()
	}

    method blowUp() {
        game.sound("sfx_hit_basic.mp3").play()
        self.dieByBlowUpDamage()
        self.blowUpAnimation()
        game.schedule(1500, {self.blowUpEffect()})
    }

    method dieByBlowUpDamage(){
        hp = 0
        movementTick.stop()
        tdGame.discountEnemy(self) 
        aoe.refreshPosition(position)
    }

    method blowUpAnimation(){
        game.schedule(500, {status = "exploding_1"})
        game.schedule(1000, {status = "exploding_2"})
        game.schedule(1500, {status = "dying"})
    }

    method blowUpEffect(){
        aoe.flash()
        self.enemiesInRange(tdGame.enemiesInPlay()).forEach({enemy => enemy.receiveBlowUpDamage(power)})
        game.sound("sfx_alf_pop.wav").play()
        game.schedule(1000, {self.despawn()})
    }

    method enemiesInRange(enemies) = enemies.filter({ enemy => self.isInRange(enemy) })
  
    method isInRange(enemy) = position.distance(enemy.position()) <= radius

    method clone() = new ExplosiveEnemy(hp = hp, power = power, speed = speed, name = name)

}

// Area of Effect 🥸
const aoe2 = new RangePrevisualizer(position = game.at(99,99), range = 2)
