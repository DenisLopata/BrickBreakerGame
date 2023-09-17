extends CollisionShape2D

@onready var _screen_size := self.get_viewport_rect().size

# Called when the node enters the scene tree for the first time.
func _ready():
	var parent_node = get_parent() as StaticBody2D
	if parent_node.name.contains("Wall"):
		shape.size = Vector2(20, _screen_size.y)
	elif parent_node.name == "Floor":
		var finger_area = _screen_size / 5
		shape.size = Vector2(_screen_size.x, finger_area.y)
	else:
		shape.size = Vector2(_screen_size.x, 20)
			


