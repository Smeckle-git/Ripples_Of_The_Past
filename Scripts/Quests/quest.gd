class_name Quest extends QuestManager

#base class for making quest
func start_quest() -> void:
	if quest_status == QuestStatus.available:
		find_update_canvas("started", "Started Quest: " + str(quest_name)) # visual update on screen
		find_update_journal()
		quest_status = QuestStatus.started
		QuestTitle.text = quest_name
		QuestDescription.text = str(collect_obj) + "/" + str(amount_obj) +" "+ quest_description
		QuestDetails.text = quest_details
		
func update_goal()-> void:
	if quest_status == QuestStatus.started || quest_status == QuestStatus.update_goal:
		quest_status = QuestStatus.update_goal
		collect_obj +=1
		QuestDescription.text = str(collect_obj) + "/" + str(amount_obj) +" "+ quest_description
		find_update_canvas("updated", str(collect_obj) + "/" + str(amount_obj) + " " + quest_description) # visual update on screen
		find_update_journal()
		if collect_obj == amount_obj:
			reached_goal()
			
func reached_goal() -> void:
	if quest_status == QuestStatus.update_goal:
		find_update_canvas("updated", str(reached_goal_text)) # visual update on screen
		find_update_journal()
		quest_status = QuestStatus.reached_goal
		QuestDescription.text = reached_goal_text

func finish_quest() -> void:
	if quest_status == QuestStatus.reached_goal:
		find_update_canvas("completed", "Quest completed!") # visual update on screen
		find_update_journal()
		quest_status = QuestStatus.finished
		GameHudManager.reputation += Reputation_amount 
		update_karma()
		print_debug(KarmaGlobal.KARMA_SCORE)

# create function that update the amount of picked up parts
