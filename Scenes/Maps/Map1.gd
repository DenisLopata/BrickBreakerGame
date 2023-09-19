extends Node2D

@onready var _screen_size := self.get_viewport_rect().size
@onready var floor := $Floor as StaticBody2D
@onready var ceiling := $Ceiling as StaticBody2D
@onready var wall_left := $WallLeft as StaticBody2D
@onready var wall_right := $WallRight as StaticBody2D
@onready var tile_holder := $TileHolder as Node
#@onready var tile_node :=  preload("res://Scenes/Enitities/Tiles/Base/Tile.tscn")
@onready var tile_manager_node :=  preload("res://Scenes/Enitities/Tiles/TileManager.tscn")

var brick_margin := 20 as int
var area_margin := Vector2i.ZERO
var level : int
var number_of_bricks := 0 as int

func _ready() -> void:
	level = 1
	create_level()

func create_level() -> void :
	_generate_collision_borders()
	_generate_tiles()
	

func _generate_tiles() -> void:
	GameData.number_of_bricks_level = 0
	number_of_bricks = 0
	#we instantiate tile manager
	var tile_manager = tile_manager_node.instantiate()
	add_child(tile_manager)
	
	
	#we render one tile to get its dimensions
	var tile_type = tile_manager.get_tile_type(level)
	var first_tile = tile_type.instantiate()
	add_child(first_tile)
	var tile_dimensions := first_tile.tile_size as Vector2
	first_tile.queue_free()
	
	#set to tile x dimenasion
	area_margin = tile_dimensions
	
	var tile_area_y_min = 0 + 200
	var tile_area_x_min = 0 + area_margin.x * 2
	var tile_area_y_max = _screen_size.y / 2 - area_margin.y
	var tile_area_x_max = _screen_size.x - area_margin.x * 2
	
	
	var x_range := range(tile_area_x_min, tile_area_x_max, tile_dimensions.x + brick_margin)
	var y_range := range(tile_area_y_min, tile_area_y_max, tile_dimensions.y + brick_margin)
	
	var columns := x_range.size()
	var rows := y_range.size()
	#generate brick tiles in borders, step is brick dimenstion
	for x in x_range:
		for y in y_range:
			#TODO center bricks on level better
#			if x > tile_area_x_min and x < tile_area_x_max - tile_dimensions.x:
#				if y > tile_area_y_min and y < tile_area_y_max - tile_dimensions.x:
			var tile = tile_manager.get_tile_type(level).instantiate()
			tile.position = Vector2(x, y)
			tile_holder.add_child(tile)
			number_of_bricks = number_of_bricks + 1
			
	#add number of bricks on level to singleton
	GameData.number_of_bricks_level = number_of_bricks
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
	
