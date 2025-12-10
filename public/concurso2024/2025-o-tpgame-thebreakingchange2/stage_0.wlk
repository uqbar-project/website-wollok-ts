import models_game.*
import models_enemies.*

const stage_0 = new Stage(
  path = path,
  resources = 1000,
  rounds = new Queue(list = [round_3, round_0, round_1, round_2 , round_4]),
  optimized_path_image = "optimized_stage_0.png"
)

// Path Configuration
const path = [
  new Road(position = game.at(0, 7)),
  new Road(position = game.at(1, 7)),
  new Road(position = game.at(2, 7)),
  new Road(position = game.at(3, 7)),
  new Road(position = game.at(4, 7)),
  new Road(position = game.at(5, 7)),
  new Road(position = game.at(6, 7)),
  new Road(position = game.at(7, 7)),
  new Road(position = game.at(8, 7)),
  new Road(position = game.at(9, 7)),
  new Road(position = game.at(10, 7)),
  new Road(position = game.at(11, 7)),
  new Road(position = game.at(12, 7)),
  new Road(position = game.at(13, 7)),
  new Road(position = game.at(14, 7)),
  new Road(position = game.at(15, 7)),
  new Core(position = game.at(16, 7))
]

const a = new MutablePosition()


const round_0 = new Round(
  enemiesQueue = new Queue(
    list = [
      new BasicEnemy(hp = 1),
      new BasicEnemy(hp = 2),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy()
    ]
  ),
  resourcesReward = 100
)

const round_1 = new Round(
  enemiesQueue = new Queue(
    list = [
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new ArmoredEnemy()
    ]
  ),
  resourcesReward = 200
)

const round_2 = new Round(
  enemiesQueue = new Queue(
    list = [
      new ArmoredEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new BasicEnemy(),
      new ArmoredEnemy(),
      new BasicEnemy(),
      new ArmoredEnemy(),
      new BasicEnemy(), 
      new ArmoredEnemy(),
      new ExplosiveEnemy()
    ]
  ),
  resourcesReward = 200
)

const round_3 = new Round(
  enemiesQueue = new Queue(
    list = [new ExplosiveEnemy(), new ExplosiveEnemy(), new ExplosiveEnemy(), new ExplosiveEnemy(), new ExplosiveEnemy(), new BasicEnemy(hp = 3)]
  ),
  resourcesReward = 100
)

const round_4 = new Round(
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
  resourcesReward = 200
)