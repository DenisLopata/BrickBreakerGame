extends Node2D

@onready var _screen_size := self.get_viewport_rect().size
@onready var floor := $Floor as StaticBody2D
@onready var ceiling := $Ceiling as StaticBody2D
@onready var wall_left := $WallLeft as StaticBody2D
@onready var wall_right := $WallRight as StaticBody2D
@onready var tile_holder := $TileHolder as Node
@onready var tile_node :=  preload("res://Scenes/Enitities/Tiles/Base/Tile.tscn")


func _ready() -> void:
	_generate_collision_borders()
	_generate_tiles()


func _generate_tiles() -> void:
	var area_margin := 32 as int
	var tile_area_y_min = 0 + area_margin
	var tile_area_x_min = 0 + area_margin
	var tile_area_y_max = _screen_size.y / 2
	var tile_area_x_max = _screen_size.x - area_margin
	
	#we render one tile to get its dimensions
	var first_tile = tile_node.instantiate()
	add_child(first_tile)
	var tile_dimensions := first_tile.tile_size as Vector2
	first_tile.queue_free()
	
	var brick_margin := 4 as int
	#generate brick tiles in borders, step is brick dimenstion
	for x in range(tile_area_x_min, tile_area_x_max, tile_dimensions.x + brick_margin):
		for y in range(tile_area_y_min, tile_area_y_max, tile_dimensions.y + brick_margin):
			#TODO center bricks on level better
			if x > tile_area_x_min and x < tile_area_x_max - tile_dimensions.x:
				if y > tile_area_y_min and y < tile_area_y_max - tile_dimensions.x:
					var tile = tile_node.instantiate()
					tile.position = Vector2(x, y)
					tile_holder.add_child(tile)
	
	pass

func _generate_collision_borders() -> void:
	floor.position.x = _screen_size.x / 2
	floor.position.y = _screen_size.y
	
	ceiling.position.x = _screen_size.x / 2
	ceiling.position.y = -10
	
	wall_left.position.x = -10
	wall_left.position.y = _screen_size.y / 2
	
	wall_right.position.x = _screen_size.x + 10
	wall_right.position.y = _screen_size.y / 2
	
