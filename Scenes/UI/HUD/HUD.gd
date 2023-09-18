extends CanvasLayer

@onready var level_score_text_node := $MC/VB/HB/LevelScoreText as Label
@onready var level_score_value_node := $MC/VB/HB/LevelScoreValue as Label
@onready var level_life_text_node := $MC/VB/HB/LevelLifeText as Label
@onready var level_life_value_node := $MC/VB/HB/LevelLifeValue as Label
@onready var center_message_label := $MC/VB/VB/CenterMessage as Label


func set_level_score_value(value : int) -> void:
	var new_score := increment_score_by_value(value)
	level_score_value_node.text = str(new_score)

func increment_score_by_value(value : int) -> int:
	var current_score := int(level_score_value_node.text)
	current_score = current_score + value
	return current_score

func set_level_life_value(value : int) -> void:
	level_score_text_node.text = str(value)
	
func set_center_message_label_text(text : String) -> void:
	center_message_label.text = text
