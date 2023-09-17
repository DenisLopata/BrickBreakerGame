class_name Tile
extends StaticBody2D

@export var health := 1 : set = _set_tile_health

@onready var sprite := $Sprite2D as Sprite2D

var tile_size : Vector2

#delete object when it reaches 0 health
func _set_tile_health(val: int) -> void:
	
	#on zero health destroy
	if val == 0:
		queue_free()
		return
	
	health = val
	pass

func _ready():
	_tile_size()

func _tile_size() -> void:
	var texture_size = sprite.texture.get_size()
	var size_scaled = texture_size * scale
	tile_size = size_scaled
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
