import models_game.*
import models_enemies.*

const stage_2 = new Stage(
  path = path,
  resources = 50,
  rounds = new Queue(list = [round_0, round_1, round_2, round_3]),
  optimized_path_image = "optimized_stage_2.png"
)

// Path Configuration
const path = [
  new Road(position = game.at(0,7)),
  new Road(position = game.at(1,7)),
  new Road(position = game.at(1,6)),
  new Road(position = game.at(1,5)),
  new Road(position = game.at(1,4)),
  new Road(position = game.at(2,4)),
  new Road(position = game.at(3,4)),
  new Road(position = game.at(4,4)),
  new Road(position = game.at(5,4)),
  new Road(position = game.at(6,4)),
  new Road(position = game.at(6,5)),
  new Road(position = game.at(6,6)),
  new Road(position = game.at(6,7)),
  new Road(position = game.at(6,8)),
  new Road(position = game.at(6,9)),
  new Road(position = game.at(6,10)),
  new Road(position = game.at(8,10)),
  new Road(position = game.at(9,10)),
  new Road(position = game.at(10,10)),
  new Road(position = game.at(11,10)),
  new Road(position = game.at(11,9)),
  new Road(position = game.at(11,8)),
  new Road(position = game.at(11,7)),
  new Road(position = game.at(11,6)),
  new Road(position = game.at(11,5)),
  new Road(position = game.at(12,5)),
  new Road(position = game.at(13,5)),
  new Road(position = game.at(14,5)),
  new Road(position = game.at(15,5)),
  new Road(position = game.at(16,5)),
  new Road(position = game.at(16,6)),
  new Road(position = game.at(16,7)),
  new Road(position = game.at(15,7)),
  new Road(position = game.at(14,7)),
  new Road(position = game.at(14,6)),
  new Road(position = game.at(14,5)),
  new Road(position = game.at(14,4)),
  new Road(position = game.at(14,3)),
  new Road(position = game.at(14,2))
]

const round_0 = new Round(
  enemiesQueue = new Queue(
    list = [
      new BasicEnemy(),
      new BasicEnemy() 
    ]
  ),
  resourcesReward = 50
)

const round_1 = new Round(
  enemiesQueue = new Queue(
    list = [
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy()
    ]
  ),
  resourcesReward = 100
)

const round_2 = new Round(
  enemiesQueue = new Queue(
    list = [
      new ArmoredEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new ArmoredEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy()
    ]
  ),
  resourcesReward = 150
)

const round_3 = new Round(
  enemiesQueue = new Queue(
    list = [
      new BasicEnemy(),
      new ArmoredEnemy(),
      new ExplosiveEnemy(),
      new BasicEnemy(),
      new ExplosiveEnemy(),
      new ArmoredEnemy(),
      new ExplosiveEnemy(),
      new ExplosiveEnemy(),
      new ExplosiveEnemy()
    ]
  ),
  resourcesReward = 0
)