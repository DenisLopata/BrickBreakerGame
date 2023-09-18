extends Node

@onready var map1_node := $Map1
@onready var player_node := $Player
@onready var ball_node := $Ball
@onready var hud_node := $HUD
@onready var game_start_timer := $GameStartTimer

var level_start_time = 4 as int

signal game_start_time_change(time: int)

func _ready():
	ball_node.ball_hit_brick.connect(Callable(hud_node, "set_level_score_value"))
	self.game_start_time_change.connect(Callable(hud_node, "set_center_message_label_text"))
	game_start_timer.wait_time = 1
	
func _start_center_message_timer() -> void:
	game_start_timer.start()
	game_start_timer.timeout.connect(self._on_signal_game_start_timer_timeout)

func _on_signal_game_start_timer_timeout() -> void:
	if level_start_time == 0:
		return
	level_start_time -= 1
	game_start_time_change.emit(str(level_start_time))


func start_game() -> void:
	_start_center_message_timer() 
