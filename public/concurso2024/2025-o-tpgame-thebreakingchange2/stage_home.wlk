import models_game.*
import stage_2.stage_2
import stage_3.stage_3

const stage_home = new HomeStage(
	path = path,
	resources = 0,
	rounds = new Queue(list = [placeHolderRound]),
	optimized_path_image = "optimized_stage_selector.png",
	stageSelectors = stageSelectors
)

const placeHolderRound = new Round(enemiesQueue = new Queue(list = []) , resourcesReward = 100)

const stageSelectors = [
	new StageSelectorTile(position = game.at(8, 2), name = "T", stage = stage_2),
	new StageSelectorTile(position = game.at(10, 2), name = "Y", stage = stage_3)
]

const path = [
// W
new Road(position = game.at(1, 11)),
new Road(position = game.at(1, 10)),
new Road(position = game.at(1, 9)),
new Road(position = game.at(1, 8)),
new Road(position = game.at(2, 7)),
new Road(position = game.at(3, 8)),
new Road(position = game.at(3, 9)),
new Road(position = game.at(4, 7)),
new Road(position = game.at(5, 8)),
new Road(position = game.at(5, 9)),
new Road(position = game.at(5, 10)),
new Road(position = game.at(5, 11)),
//T

new Road(position = game.at(7, 12)),
new Road(position = game.at(9, 12)),
new Road(position = game.at(11, 12)),

new Road(position = game.at(7, 11)),
new Road(position = game.at(8, 11)),
new Road(position = game.at(8, 10)),
new Road(position = game.at(8, 9)),
new Road(position = game.at(8, 8)),
new Road(position = game.at(8, 7)),


new Road(position = game.at(9, 11)),
new Road(position = game.at(10, 11)),
new Road(position = game.at(10, 10)),
new Road(position = game.at(10, 9)),
new Road(position = game.at(10, 8)),
new Road(position = game.at(10, 7)),

new Road(position = game.at(11, 11)),
// new Road(position = game.at(9, 10)),
// new Road(position = game.at(9, 9)),
// new Road(position = game.at(9, 8)),
new Road(position = game.at(9, 7)),
//D
new Road(position = game.at(13, 11)),
new Road(position = game.at(14, 11)),
new Road(position = game.at(15, 11)),
new Road(position = game.at(13, 10)),
new Road(position = game.at(13, 9)),
new Road(position = game.at(13, 8)),
new Road(position = game.at(13, 7)),
new Road(position = game.at(14, 7)),
new Road(position = game.at(15, 7)),
new Road(position = game.at(16, 8)),
new Road(position = game.at(16, 9)),
new Road(position = game.at(16, 10))
]


