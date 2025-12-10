import models_hud.*
import stage_home.stage_home
import stage_0.stage_0
import stage_2.stage_2
import stage_3.stage_3
import models_towers.*

const optimized_mode = true

const stageList = [stage_2, stage_3]
object tdGame {
	var selectedStage = stage_home
	var currentStage = selectedStage.clone()

	method currentStage() = currentStage
	
	method setupGame() {
		game.title("Tower Defense")
		game.height(14)
		game.width(23)
		game.cellSize(60)
		game.start()
		player.refreshPrevisualizer()
		self.displayBackground()
		self.setupPlayZone()
	}

	method setupPlayZone(){

	}

	method displayBackground() {
		if (optimized_mode) game.boardGround("optimized_background.png")
		else game.ground("tile_default.png")
	}

	method setupControls() {
		keyboard.e().onPressDo({ self.startCurrentRound() })
		keyboard.r().onPressDo({ self.swapStages(stage_home) })
		keyboard.t().onPressDo({ self.swapStages(stage_2) })
		keyboard.y().onPressDo({ self.swapStages(stage_3) })
		keyboard.u().onPressDo({ self.swapStages(stage_0) })
		player.controlSetup()
	}

	method start() {
		self.setupGame()
		self.setupControls()
		currentStage.load()
		hud.beDisplayed()
		game.addVisual(player)
	}
	
	method swapStages(stage) {
		self.clearCurrentStage()
		self.selectNewStage(stage)
		self.loadCurrentStage()
	}

	method clearCurrentStage(){
		currentStage.clear()
		victoryScreen.beRemoved()
		gameOverScreen.beRemoved()
		player.exitTowerSelectionMode()
		player.position(game.at(9,4))
	}

	method selectNewStage(stage){
		selectedStage = stage
		currentStage = selectedStage.clone()
	}

	method loadCurrentStage(){
		currentStage.load()
		player.refreshVisualZIndex()
		player.refreshPrevisualizer()
	}

	method startCurrentRound() {
		currentStage.startCurrentRound()
	}

	method discountEnemy(enemy) {
		currentStage.discountEnemy(enemy)
	}

	method enemiesRemaining() = currentStage.enemiesRemaining()

	method enemiesInPlay() = currentStage.enemiesInPlay()

	method completeRound() {
		currentStage.completeRound()	
	}

	method markStageAsWin() {
		selectedStage.markAsWin()
		self.winCheck()
	}

	method hp() = currentStage.hp()

	method roundsRemaining() = currentStage.roundsRemaining()

	method resources() = currentStage.resources()

	method addTower(tower) { currentStage.addTower(tower)}

	method prohibitedZones() = currentStage.prohibitedZones()

	method towers() = currentStage.towers()

	method sellTower(tower) { currentStage.sellTower(tower)}

	method checkTowersCollide() = currentStage.checkTowersCollide()

	method checkBombsCollide() = currentStage.checkBombsCollide()

	method isWin() = stageList.all({stage => stage.isWin()})

	method winCheck() {
		if (self.isWin()) self.win()
	}

	method win(){
		stage_home.setWinMode()
	}

	method spawnBomb(){
		currentStage.spawnBomb()
	}

	method removeBomb(bomb){
		currentStage.removeBomb(bomb)
	}
}

class RangePrevisualizer{
	var property position
	var property range
	var tiles = []

	method tiles() = tiles

	method beDisplayed() {
	  tiles.forEach({tile => tile.beDisplayed()})
	}

	method beRemoved() {
		game.removeVisual(self)
		tiles.forEach({tile => tile.beRemoved()})
	}

	method flash(){
		self.beDisplayed()
		game.schedule(1000, {self.beRemoved()})
	}

	method tilesSquare() {
		const tilesSquare = []
		(position.x()-range .. position.x()+range).forEach({tileX => (position.y()-range .. position.y()+range).forEach({tileY => tilesSquare.add(new PrevisualizerTile(position = new MutablePosition(x= tileX, y=tileY), offsetX = tileX - position.x(), offsetY = tileY - position.y()))})})
		return tilesSquare
	}

	method tilesArea() = self.tilesSquare().filter({tile => position.distance(tile.position()) <= range })

	method setPreviewTiles() {
		tiles = self.tilesArea()
	}

	method refreshPosition(newPosition) {
		position = newPosition
		tiles.forEach({tile => tile.refresh(position)})
	}

	method refreshPreview(displayAfterRefresh) {
		range = player.towerToPlace().range()
		self.beRemoved()
		self.setPreviewTiles()
		if (displayAfterRefresh) {
			self.beDisplayed()
		}
		
	}

	method clone() = new RangePrevisualizer(position = position, range = range, tiles = tiles.map({tile => tile.clone()}))

	method cloneWithTiles() {
		self.setPreviewTiles()
		return new RangePrevisualizer(position = position, range = range, tiles = tiles.map({tile => tile.clone()}))
	}

}

class PrevisualizerTile {
	var property position
	const offsetX
	const offsetY

	method image() = "tile_rangePreview.png"

	method beDisplayed() {
	  game.addVisual(self)
	}

	method beRemoved() {
		game.removeVisual(self)
	}

	method refresh(newCenterPosition) {
		position.x(newCenterPosition.x() + offsetX)
		position.y(newCenterPosition.y() + offsetY)
	}

	method clone() = new PrevisualizerTile(position = position, offsetX = offsetX, offsetY = offsetY)

}

object player {
	var property position = game.at(9,4)
	var isPlacingTower = false
	var towerToPlace = basicTower
	var image = "player.png"
	const rangePrevisualizer = new RangePrevisualizer(position = position, range = towerToPlace.range())
	
	method image() = image
	method towerToPlace() = towerToPlace
	method towerToPlace(tower) { towerToPlace = tower }

	method toggleTowerSelectionMode(){
		if (isPlacingTower) self.exitTowerSelectionMode()
		else self.enterTowerSelectionMode()
	}

	method enterTowerSelectionMode() {
		image = towerToPlace.image()
		rangePrevisualizer.beDisplayed()
		isPlacingTower = true
	}

	method exitTowerSelectionMode() {
		image = "player.png"
		rangePrevisualizer.beRemoved()
		isPlacingTower = false

	}

	method addTower(tower) {
		if (isPlacingTower){
			if (self.isInBuildingZone()) {
				tdGame.addTower(towerToPlace.cloneInPosition(position))
				self.exitTowerSelectionMode()
			}
			else {
				game.sound("sfx_cannot_build.mp3").play()
			}
		}
	}
	
	method isInBuildingZone() = tdGame.prohibitedZones().any(
		{ element => element.position() == position }
	).negate()

	method controlSetup() {
		//Movement
		keyboard.w().onPressDo({ self.moveUp() })
    	keyboard.a().onPressDo({ self.moveLeft() })
    	keyboard.s().onPressDo({ self.moveDown() })
		keyboard.d().onPressDo({ self.moveRight() })
		//Tower Selection
		keyboard.q().onPressDo({ self.toggleTowerSelectionMode()})
		keyboard.num1().onPressDo({ self.selectTower(basicTower)})
		keyboard.num2().onPressDo({ self.selectTower(piercingTower)})
		keyboard.num3().onPressDo({ self.selectTower(slowingTower)})
		keyboard.space().onPressDo({ self.addTower(towerToPlace)})

		keyboard.x().onPressDo({ self.sellTower(self.towerInCurrentPosition()) })
	}

	method selectTower(tower) {
		self.towerToPlace(tower)
		rangePrevisualizer.refreshPreview(isPlacingTower)
		if (isPlacingTower) {
		image = towerToPlace.image()
		}
	}

	method refreshPrevisualizer(){
		rangePrevisualizer.refreshPreview(false)
		rangePrevisualizer.refreshPosition(position)
	}

	method sellTower(tower) {
		if(tower != null) {
			tdGame.sellTower(tower)
		}
	}

	method towerInCurrentPosition() {
		const towerInList = tdGame.towers().filter({tower => tower.position() == self.position()})
		if (towerInList.isEmpty()){
			return null
		}
		return towerInList.head()
		}

	method movementActions(){
		rangePrevisualizer.refreshPosition(position)
		tdGame.checkTowersCollide()
		tdGame.checkBombsCollide()
	}

	method moveUp() {
		if(position.y() < game.height()-1) self.position(position.up(1))
		self.movementActions()
	}

	method moveDown() {
		if(position.y() > 0) self.position(position.down(1))
		self.movementActions()
	}

	method moveLeft() {
		if (position.x() > 0) self.position(position.left(1))
		self.movementActions()
	}

	method moveRight(){
		if (position.x() < hud.limit()) self.position(position.right(1))
		self.movementActions()
	}

	method refreshVisualZIndex() {
		game.removeVisual(self)
		game.addVisual(self)
	}
}

class Stage {
	const path
	var rounds
	const towers = []
	var currentRound = new Round(enemiesQueue = [], resourcesReward = 0)
	var resources
	var hp = 100
	var optimized_path_image = null
	var status = "pending"
	
	method path() = path
	method towers() = towers
	method resources() = resources
	method currentRound() = currentRound
	method hp() = hp
	method status() = status

	method sellTower(tower){
		tower.despawn()
		towers.remove(tower)
		self.addResources(tower.sellPrice())
	}

	method load() {
		self.displayPath()
		currentRound = rounds.dequeue()
	}
	
	method clear() {
		self.removePath()
		currentRound.clear()
		towers.forEach({tower => tower.despawn()})
		rounds = []
	}

	method clone() = new Stage(path = path, rounds = rounds.clone(), resources = resources, optimized_path_image = optimized_path_image) 
	
	method roundsRemaining() = rounds.size() + 1
	
	method addResources(amount) {
		resources += amount
		game.sound("sfx_resources_added.wav").play()
	}
	
	method substractResources(amount) {
		resources -= amount
	}
	
	method startCurrentRound() {
		currentRound.start(path)
	}
	
	method win() {
		if(!self.shouldLose()){
			tdGame.markStageAsWin()
			victoryScreen.beDisplayed()
		}
	}
	
	method lose() {
		gameOverScreen.beDisplayed()
		resources = 0
		self.clear()
	}
	
	method completeRound() {
		if (self.isComplete()) {
			self.win()
		} else {
			self.addResources(currentRound.resourcesReward())
			currentRound = rounds.dequeue()
		}
	}
	
	method isComplete() = rounds.size() == 0
	
	method addTower(tower) {
		if (tower.cost() <= resources) {
			self.substractResources(tower.cost())
			towers.add(tower)
			tower.spawn()
		} else {
			game.sound("sfx_cannot_build.mp3").play()
		}
	}
	
	method displayPath() {
		if (optimized_mode) {
			pathDisplayer.pathImage(optimized_path_image)
			game.addVisual(pathDisplayer)
		}
		else path.forEach({ road => road.beDisplayed()})
	}

	method removePath() {
		if (optimized_mode)	game.removeVisual(pathDisplayer)
		else path.forEach({ road => game.removeVisual(road)})
	}

	method discountEnemy(enemy) {
		currentRound.discountEnemy(enemy)
	}

	method enemiesRemaining() = currentRound.enemiesRemaining()

	method enemiesInPlay() = currentRound.enemiesInPlay()

	method receiveDamage(damage) {
		hp -= damage
		game.sound("sfx_hit_core.wav").play()
		if(self.shouldLose()){
			self.lose()	
		}
	}

	method shouldLose() = hp <= 0

	method prohibitedZones() = path + towers

	method checkTowersCollide() {
		towers.forEach({tower => tower.checkCollide()})
	}

	method checkBombsCollide() {
		currentRound.checkBombsCollide()
	}

	method markAsWin(){
		status = "win"
	}

	method isWin() = status == "win"

	method spawnBomb(){

		currentRound.spawnBomb(self.availableBombZone())
	}

	method availableBombZone() = self.availableBombZones().anyOne()

	method availableBombZones() = [
		game.at(1,1),
		game.at(7,7),
		game.at(10,9),
		game.at(4,4),
		game.at(6,6),
		game.at(3,1),
		game.at(1,3),
		game.at(12,12)

	].asSet().difference(self.notBombZone())

	method notBombZone() = self.roundBombsZones()


	method roundBombsZones() {
		return currentRound.bombZones()
	}

	method playZone() {
		const list = []
		(0..17).forEach({ x => (0..13).forEach({y => list.add(new Position(x = x, y=y))})})
		return list.asSet()
	}

	method removeBomb(bomb){
		currentRound.removeBomb(bomb)
	}

}

class Road {
	const property position
	
	method image() = "tile_road.png"

	method beDisplayed() = game.addVisual(self)
}

class Core {
	var property position
	
	method image() = "tile_core.png"

	method beDisplayed() {
		game.addVisual(self)
	}
}

class Round {
	const enemiesQueue
	const enemiesInPlay = []
	const resourcesReward
	const enemySpawnFrequency = 1500
	var enemySpawnTick = game.tick(1500, { }, false)
	const bombList = []
	
	method enemiesQueue() = enemiesQueue
	method enemiesRemaining() = enemiesQueue.size() + enemiesInPlay.size()
	
	method enemiesInPlay() = enemiesInPlay
	
	method resourcesReward() = resourcesReward

	method clone() = new Round(enemiesQueue = enemiesQueue.clone(), resourcesReward = resourcesReward)
	

	method clear() {
		enemySpawnTick.stop()
		enemiesInPlay.forEach({ enemy => enemy.despawn()})
		bombList.forEach({bomb => bomb.despawn()})
	}
		
	method start(path) {
		if (!enemySpawnTick.isRunning()){
			enemySpawnTick = game.tick(enemySpawnFrequency, { self.spawnNextEnemy(path) }, true)
			enemySpawnTick.start()
		}
	}
	
	method spawnNextEnemy(path) {
		if (!enemiesQueue.isEmpty()) {
			const enemy = enemiesQueue.dequeue()
			enemy.spawn(path)
			enemiesInPlay.add(enemy)
		}
	}
	
	method end() {
		enemySpawnTick.stop()
		tdGame.completeRound()
		self.clearBombs()
	}

	method clearBombs() {
		bombList.forEach({b => b.despawn()})
	}
	
	method discountEnemy(enemy) {
		enemiesInPlay.remove(enemy)
		if (self.isComplete()) self.end()
	}

	method isComplete() = self.enemiesRemaining() == 0

	method spawnBomb(position){
		const bomb = new Bomb(position = position)
		bomb.spawn()
		self.addBomb(bomb)
	}

	method addBomb(bomb){
		bombList.add(bomb)
	}

	method bombZones() = bombList.map({b => b.position()}).asSet()

	method removeBomb(bomb) {
		bombList.remove(bomb)
	}

	method checkBombsCollide() {
		bombList.forEach({bomb => bomb.checkCollide()})
	}
}

class Bomb {
	var property position
	var timer = 3
	const countdownTick = game.tick(2000, {self.countdown()}, false)

	method image() = "bomba.png"
	method text() = timer.toString()
	method textColor() = "FFFFFFFF"

	method spawn(){
		game.addVisual(self)
		countdownTick.start()
	}
	method despawn(){
		countdownTick.stop()
		tdGame.removeBomb(self)
		game.removeVisual(self)
	}
	method blowUp(){
		self.doDamage(tdGame.currentStage())
		self.despawn()
	}

	method doDamage(damageable){
		damageable.receiveDamage(5)
	}

	method countdown(){
		timer -= 1
		if (self.shouldBlowUp()){
			self.blowUp()
		}
	}

	method shouldBlowUp() = timer <= 0

	method checkCollide() {
		if (position == player.position()) self.defuse()
	}

	method defuse(){
		game.sound("sfx_defuse.wav").play()
		self.despawn()
	}

}

class Queue {
	const list = []

	method enqueue(element) {
		list.add(element)
	}

	method clone() {
		// La buena lista, nada le gana
		const clonedQueue = new Queue(list = [])
		list.forEach({element => clonedQueue.enqueue(element.clone())})
		return clonedQueue
	}

	method dequeue() {
		if (list.isEmpty()) return null
		const head = list.head()
		list.remove(list.head())
		return head
	}

	method size() = list.size()

	method isEmpty() = list.isEmpty()
}

class HomeStage inherits Stage() {
	const stageSelectors
	method displayStageSelectors(){
		stageSelectors.forEach({selector => selector.beDisplayed()})
	}

	method removeStageSelectors(){
		stageSelectors.forEach({selector => selector.beRemoved()})
	}

	override method load(){
		super()
		self.displayStageSelectors()
	}

	override method clear(){
		super()
		self.removeStageSelectors()
	}
	
	method setWinMode(){
		optimized_path_image = "true_ending.png"
	}

	override method clone() = new HomeStage(path = path, rounds = rounds.clone(), resources = resources, optimized_path_image = optimized_path_image, stageSelectors = stageSelectors) 

}

class StageSelectorTile {
	const property position
	const name
	const stage

	method image() = "tile_selector_" + stage.status() + ".png"
	method text() = name
	method textColor() = "FFFFFFFF"

	method beDisplayed() {
		game.addVisual(self)
	}

	method beRemoved() {
		game.removeVisual(self)
	}
}

object pathDisplayer {
	const property position = game.at(0,0)
	var pathImage = "optimized_stage_selector.png"

	method pathImage(newImage){ pathImage = newImage }
	method image() = pathImage
}