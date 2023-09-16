extends StaticBody2D

var health := 1 : set = _set_tile_health

@onready var sprite := $Sprite2D as Sprite2D

@export var tile_size : Vector2

#delete object when it reaches 0 health
func _set_tile_health(val: int) -> void:
	if val == 0:
		queue_free()

func _ready():
	var texture_size = sprite.texture.get_size()
	var size_scaled = texture_size * sprite.scale
	tile_size = size_scaled


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
