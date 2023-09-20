extends CanvasLayer

@onready var level_score_text_node := $MC/VB/HB/LevelScoreText as Label
@onready var level_score_value_node := $MC/VB/HB/LevelScoreValue as Label
@onready var level_life_text_node := $MC/VB/HB/LevelLifeText as Label
@onready var level_life_value_node := $MC/VB/HB/LevelLifeValue as Label
@onready var center_message_label := $MC/VB/VB/CenterMessage as Label
@onready var bttn_next_level := $MC/VB/VB/ButtonNextLevel as Button

signal switch_to_next_level

func _ready():
	var stri = ""
	reset_hud_text()
	var cutout_size = DisplayServer.get_display_cutouts()
	var safe_area_size = DisplayServer.get_display_safe_area()
	if cutout_size:
		for coutout in cutout_size:
			stri += str(coutout.size.y) + ", "
	level_life_value_node.text = str(stri)
#	level_life_value_node.text = str(cutout_size)

func reset_hud_text() -> void:
	center_message_label.visible = false
	bttn_next_level.visible = false
	

func set_level_score_value(brick_health : int) -> void:
	var new_score := _increment_score_by_value(brick_health)
	level_score_value_node.text = str(new_score)

func _increment_score_by_value(value : int) -> int:
	var current_score := int(level_score_value_node.text)
	current_score = current_score + value
	return current_score

func set_level_life_value(value : int) -> void:
	level_score_text_node.text = str(value)
	
func set_center_message_label_text(text : String) -> void:
	if not center_message_label.visible:
		center_message_label.visible = true
		
	center_message_label.text = text
	
	if int(text) == 0:
		center_message_label.visible = false
	
func on_signal_level_finished() -> void:
	center_message_label.visible = true
	center_message_label.text = "victory"
	bttn_next_level.visible = true
	bttn_next_level.connect("pressed", self._on_signal_bttn_next_level_pressed)
	pass

func _on_signal_bttn_next_level_pressed() -> void:
	switch_to_next_level.emit()
