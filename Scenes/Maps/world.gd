extends Node2D


var room_types: Array[PackedScene]
var room_path := &"res://Scenes/Maps/room_"
var lobby := preload("res://Scenes/Maps/template.tscn")


func _ready() -> void:
	for i in range(1, 9):
		room_types.append(load(room_path + str(i) + ".tscn"))
	
	var room_position := Vector2.ZERO
	MapGenerator.generate(8)
	const iterations := MapGenerator.ARRAY_COLS * MapGenerator.ARRAY_ROWS
	for i in range(iterations):
		print("Iteration number: ", i + 1)
		if MapGenerator.map[i] != MapGenerator.ROOM_TYPE.NONE:
			var room_scene: Node2D = room_types.pick_random().instantiate()
			room_scene.global_position = room_position
			add_child(room_scene)
			print("Generated room (I hope)")
		
		if MapGenerator.map[i] == MapGenerator.ROOM_TYPE.ENTRANCE:
			var lobby_scene: Node2D = lobby.instantiate()
			lobby_scene.global_position = Vector2(room_position.x, room_position.y + 180.0)
			add_child(lobby_scene)
			print("Generated lobby (I believe)")
		
		room_position.x += 360.0
		if i % MapGenerator.ARRAY_COLS == MapGenerator.ARRAY_COLS - 1:
			room_position.x = 0.0
			room_position.y += 180.0
