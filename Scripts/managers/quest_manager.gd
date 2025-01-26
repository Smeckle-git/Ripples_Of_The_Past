class_name QuestManager extends Node3D
@onready var QuestLog: CanvasLayer = GameHudManager.get_node("QuestLog")
@onready var QuestTitle: RichTextLabel = GameHudManager.get_node("QuestLog/HUD/MarginContainer/Quest/MarginContainer/quest title")
@onready var QuestDescription: RichTextLabel = GameHudManager.get_node("QuestLog/HUD/MarginContainer/Quest/MarginContainer/quest text")
@onready var QuestDetails: RichTextLabel = GameHudManager.get_node("QuestLog/HUD/MarginContainer/Quest/MarginContainer/quest details")
#https://www.youtube.com/watch?v=Zm0eqDt0_7E&ab_channel=swydev   Min 8


#https://www.youtube.com/watch?v=-8yaaWrdQe0&ab_channel=DevWorm
@export_group("Quest Settings")
@export var quest_name: String
@export_multiline var quest_description: String
@export_multiline var quest_details: String
@export var reached_goal_text: String
@export var amount_obj: int
@export var Karma_Gained: int 
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

func find_update_canvas(status : String, content : String) -> void:
	var canvas = get_tree().get_root().get_node("Game/QuestUpdateLayer/Control")
	if canvas:
		canvas.show_and_hide(status, content)
	else:
		print("QuestUpdateCanvas not found!")

func update_karma():
	KarmaGlobal.KARMA_SCORE += Karma_Gained
