extends Node

@onready var green_tile = preload("res://Scenes/Enitities/Tiles/Normal/Green/GreenTileNormal.tscn")
@onready var blue_tile = preload("res://Scenes/Enitities/Tiles/Normal/Blue/BlueTileNormal.tscn")
@onready var red_tile = preload("res://Scenes/Enitities/Tiles/Normal/Red/RedTileNormal.tscn")

func _ready():
	pass


func get_tile_type(level: int) -> PackedScene:
	var tile_type
	match level:
		1:
			tile_type = green_tile
		2: 
			tile_type = blue_tile
		3: 
			tile_type = red_tile
		_:
			tile_type = green_tile
	return tile_type
	
