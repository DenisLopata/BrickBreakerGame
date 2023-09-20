class_name Tile
extends StaticBody2D

@export var health := 1 : set = _set_tile_health

@onready var sprite := $Sprite2D as Sprite2D


@onready var sprite_brick_1 := preload("res://Assets/Entities/Tiles/Green/Normal/tileGreen_02.png")
@onready var sprite_brick_2 := preload("res://Assets/Entities/Tiles/Blue/Normal/tileBlue_02.png")
@onready var sprite_brick_3 := preload("res://Assets/Entities/Tiles/Red/Normal/tileRed_02.png")

var tile_size : Vector2

#delete object when it reaches 0 health
func _set_tile_health(val: int) -> void:
	
	#on zero health destroy
	if val == 0:
		queue_free()
		GameData.number_of_bricks_level = GameData.number_of_bricks_level - 1
		return
	
	health = val
	#change brick sprite depending on health left
	match val:
		1:
			sprite.texture = sprite_brick_1
		2:
			sprite.texture = sprite_brick_2
		3:
			sprite.texture = sprite_brick_3
		_:
			return
	pass

func _ready():
#	scale = Vector2(1.25, 1.25)
	_tile_size()

func _tile_size() -> void:
	scale = Vector2(0.5, 0.5)
	var texture_size = sprite.texture.get_size()
	var size_scaled = texture_size * scale
	tile_size = size_scaled
	
