import models_game.*
import models_enemies.*

const stage_1 = new Stage(path = path, resources = 100, rounds = new Queue(list = [round_0]), optimized_path_image = "optimized_stage_1.png")

// Path Configuration
const path = [
// Subo
new Road(position = game.at(2, 0)),
new Road(position = game.at(2, 1)),
new Road(position = game.at(2, 2)),
new Road(position = game.at(2, 3)),
// Derecha
new Road(position = game.at(3, 3)),
new Road(position = game.at(4, 3)),
new Road(position = game.at(5, 3)),
// Subo
new Road(position = game.at(5, 4)),
new Road(position = game.at(5, 5)),
// Izquierda
new Road(position = game.at(4, 5)),
new Road(position = game.at(3, 5)),
new Road(position = game.at(2, 5)),
// Subo
new Road(position = game.at(2, 6)),
new Road(position = game.at(2, 7)),
// Derecha
new Road(position = game.at(3, 7)),
new Road(position = game.at(4, 7)),
new Road(position = game.at(5, 7)),
// Subo
new Road(position = game.at(5, 8)),
new Road(position = game.at(5, 9)),
// Izquierda
new Road(position = game.at(4, 9)),
new Road(position = game.at(3, 9)),
new Road(position = game.at(2, 9)),
// Subo
new Road(position = game.at(2, 10)),
new Road(position = game.at(2, 11)),
// Derecha
new Road(position = game.at(3, 11)),
new Road(position = game.at(4, 11)),
new Road(position = game.at(5, 11)),
new Road(position = game.at(6, 11)),
new Road(position = game.at(7, 11)),
new Road(position = game.at(8, 11)),
new Road(position = game.at(9, 11)),
// Bajo
new Road(position = game.at(9, 10)),
new Road(position = game.at(9, 9)),
new Road(position = game.at(9, 8)),
new Road(position = game.at(9, 7)),
new Road(position = game.at(9, 6)),
new Road(position = game.at(9, 5)),
new Road(position = game.at(9, 4)),
new Road(position = game.at(9, 3)),
new Road(position = game.at(9, 2)),
// Derecha
new Road(position = game.at(10, 2)),
new Road(position = game.at(11, 2)),
new Road(position = game.at(12, 2)),
new Road(position = game.at(13, 2)),
// Arriba
new Road(position = game.at(13, 3)),
new Road(position = game.at(13, 4)),
// Izquierda
new Road(position = game.at(12, 4)),
new Road(position = game.at(11, 4)),
// Abajo
new Road(position = game.at(11, 3)),
new Road(position = game.at(11, 2)),
// Derecha
new Road(position = game.at(12, 2)),
new Road(position = game.at(13, 2)),
new Road(position = game.at(14, 2)),
new Road(position = game.at(15, 2)),
// Arriba
new Road(position = game.at(15, 3)),
new Road(position = game.at(15, 4)),
new Road(position = game.at(15, 5)),
new Road(position = game.at(15, 6)),
// Izquierda
new Road(position = game.at(14, 6)),
new Road(position = game.at(13, 6)),
new Road(position = game.at(12, 6)),
new Road(position = game.at(11, 6)),
// Arriba
new Road(position = game.at(11, 7)),
new Road(position = game.at(11, 8)),
new Road(position = game.at(11, 9)),
new Road(position = game.at(11, 10)),
new Road(position = game.at(11, 11)),
// Derecha
new Road(position = game.at(12, 11)),
new Road(position = game.at(13, 11)),
// Abajo
new Road(position = game.at(13, 10)),
new Road(position = game.at(13, 9)),
new Road(position = game.at(13, 8)),
// Derecha
new Road(position = game.at(14, 8)),
new Road(position = game.at(15, 8)),
// Arriba
new Road(position = game.at(15, 9)),
new Road(position = game.at(15, 10)),
new Core(position = game.at(15, 11))
]

const round_0 = new Round(enemiesQueue = new Queue(list = [
    new BasicEnemy()

]), resourcesReward = 100)
