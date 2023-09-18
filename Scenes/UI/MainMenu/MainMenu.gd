extends Control

@onready var _screen_size := self.get_viewport_rect().size

@onready var bttn_new_game := $MC/HB/VB/NewGame

signal bttn_new_game_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	self.size = _screen_size
	bttn_new_game.connect("pressed", self._on_bttn_new_game_pressed)
	
func _on_bttn_new_game_pressed() -> void:
	bttn_new_game_pressed.emit()


