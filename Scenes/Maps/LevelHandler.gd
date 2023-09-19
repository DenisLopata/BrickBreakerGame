extends Control

@onready var _screen_size := self.get_viewport_rect().size
@onready var map1_node := $Map1
@onready var player_node := $Player
@onready var ball_node := $Ball
@onready var hud_node := $HUD
@onready var game_start_timer := $GameStartTimer
#@onready var background := $TextureRect as TextureRect

var level_start_time = 4 as int

signal game_start_time_change(time: int)
signal level_finished

func _ready():
#	self.size = _screen_size
	#TODO center background depending on screen size
#	background.position = Vector2(0, 100)
	ball_node.ball_hit_brick.connect(Callable(hud_node, "set_level_score_value"))
	ball_node.ball_hit_brick.connect(self._on_signal_ball_hit_brick)
	self.game_start_time_change.connect(Callable(hud_node, "set_center_message_label_text"))
	hud_node.switch_to_next_level.connect(self._on_signal_bttn_next_level_pressed)
	game_start_timer.wait_time = 1
	
func _start_center_message_timer() -> void:
	game_start_timer.start()
	game_start_timer.timeout.connect(self._on_signal_game_start_timer_timeout)

func _on_signal_game_start_timer_timeout() -> void:
	if level_start_time == 0:
		game_start_timer.stop()
		_start_level()
		return
	level_start_time -= 1
	game_start_time_change.emit(str(level_start_time))


func start_ready_countdown() -> void:
	_start_center_message_timer() 

func _start_level() -> void:
	ball_node.start_ball()
	player_node.start_player()
	
func _on_signal_ball_hit_brick(brick_health : int) -> void:
	var last_brick_health = brick_health
	var num_bricks_left = GameData.number_of_bricks_level 
	if num_bricks_left == 0 :
		self.connect("level_finished", Callable(hud_node, "on_signal_level_finished"))
		level_finished.emit()
	
func _on_signal_bttn_next_level_pressed() -> void:
	level_start_time = 4
	start_ready_countdown()
	hud_node.reset_hud_text()
	map1_node.create_level()
	ball_node.reset_ball()
	player_node.reset_player()
