import models_game.*
import models_enemies.*

const stage_3 = new Stage(
  path = path,
  resources = 50,
  rounds = new Queue(list = [round_0, round_1, round_2]),
  optimized_path_image = "optimized_stage_3.png"
)

// Path Configuration
const path = [
  new Road(position = game.at(0,12)),
  new Road(position = game.at(1,12)),
  new Road(position = game.at(2,12)),
  new Road(position = game.at(3,12)),
  new Road(position = game.at(4,12)),
  new Road(position = game.at(17,1)),
  new Road(position = game.at(16,1)),
  new Road(position = game.at(15,1)),
  new Road(position = game.at(14,1)),
  new Road(position = game.at(13,1)),
  new Road(position = game.at(16,13)),
  new Road(position = game.at(16,12)),
  new Road(position = game.at(16,11)),
  new Road(position = game.at(16,10)),
  new Road(position = game.at(16,9)),
  new Road(position = game.at(1,0)),
  new Road(position = game.at(1,1)),
  new Road(position = game.at(1,2)),
  new Road(position = game.at(1,3)),
  new Road(position = game.at(1,4)),
  new Road(position = game.at(7,9)),
  new Road(position = game.at(8,9)),
  new Road(position = game.at(9,9)),
  new Road(position = game.at(10,9)),
  new Road(position = game.at(11,9)),
  new Road(position = game.at(11,8)),
  new Road(position = game.at(11,7)),
  new Road(position = game.at(11,6)),
  new Road(position = game.at(11,5)),
  new Road(position = game.at(10,5)),
  new Road(position = game.at(9,5)),
  new Road(position = game.at(8,5)),
  new Road(position = game.at(7,5)),
  new Road(position = game.at(7,6)),
  new Road(position = game.at(7,7)),
  new Road(position = game.at(8,7)),
  new Core(position = game.at(9,7))
]

const round_0 = new Round(
  enemiesQueue = new Queue(
    list = [
      new BasicEnemy(hp = 1),
      new BasicEnemy(hp = 1),
      new ArmoredEnemy()
    ]
  ),
  resourcesReward = 75
)

const round_1 = new Round(
  enemiesQueue = new Queue(
    list = [
      new ArmoredEnemy(),
      new ArmoredEnemy(),
      new ExplosiveEnemy(),
      new BasicEnemy()
      
    ]
  ),
  resourcesReward = 100
)

const round_2 = new Round(
  enemiesQueue = new Queue(
    list = [
      new ExplosiveEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new ExplosiveEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new ExplosiveEnemy(),
      new BasicEnemy(),
      new ArmoredEnemy()
    ]
  ),
  resourcesReward = 0
)