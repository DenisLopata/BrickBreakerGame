extends Node2D

@onready var main_menu_node := $MainMenu
@onready var level_handler_node := $LevelHandler

var game_scene

func _ready() -> void:
	main_menu_node.connect("bttn_new_game_pressed", self._on_bttn_new_game_pressed)
	
func _on_bttn_new_game_pressed() -> void:
	main_menu_node.queue_free()
	game_scene = load("res://Scenes/Maps/LevelHandler.tscn").instantiate()
	add_child(game_scene)
	game_scene.start_game()
	
