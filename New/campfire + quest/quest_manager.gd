class_name QuestManager extends Node3D
@onready var QuestLog: CanvasLayer = $QuestLog
@onready var QuestTitle: RichTextLabel = GameHudManager.get_node("QuestLog/HUD/MarginContainer/HBoxContainer/Quest/Mar")
@onready var QuestDescription: RichTextLabel = GameHudManager.get_node("QuestLog/HUD/MarginContainer/HBoxContainer/Quest/MarginContainer/quest text")



#https://www.youtube.com/watch?v=Zm0eqDt0_7E&ab_channel=swydev   Min 8

#https://www.youtube.com/watch?v=-8yaaWrdQe0&ab_channel=DevWorm
@export_group("Quest Settings")
@export var quest_name: String
@export var quest_description: String
@export var reached_goal_text: String
@export var amount_obj: int
var collect_obj: int = 0
#All quest statuses
enum QuestStatus{
	available,
	started,
	update_goal,
	reached_goal,
	finished,
}

@export var quest_status: QuestStatus = QuestStatus.available
@export_group("Reward Settings")
@export var Reputation_amount: int # amount of rep gained or lost
