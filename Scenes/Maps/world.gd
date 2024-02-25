extends Node2D


var room_types: Array[PackedScene]
var room_path := &"res://Scenes/Maps/room_"
var lobby := preload("res://Scenes/Maps/room_0.tscn")

@onready var camera := $Camera
@onready var player: Player = $Player
@onready var chromatic_player := $Camera/CanvasLayer/ChromaticAberration/AnimationPlayer


func _ready() -> void:
	GameController.world = self
	GameController.room_changed.connect(_on_room_changed)
	
	# God please forgive me for this mess
	for i in range(1, 9):
		room_types.append(load(room_path + str(i) + ".tscn"))
	
	var index := 0  # using it for map indexing
	const COLS := MapGenerator.ARRAY_COLS
	const ROWS := MapGenerator.ARRAY_ROWS
	MapGenerator.generate(8)
	for y in range(ROWS):
		for x in range(COLS):
			index = y * COLS + x
			
			if MapGenerator.map[index] == MapGenerator.ROOM_TYPE.NONE:
				continue
			
			var room_scene = room_types.pick_random().instantiate()
			room_scene.global_position = Vector2(x * 360.0, y * 180.0)
			
			# fill paths that lead nowhere
			var to_fill: Array[int] = []
			if y - 1 < 0 or MapGenerator.map[(y - 1) * COLS + x] == MapGenerator.ROOM_TYPE.NONE:
				to_fill.append(0)
			if y + 1 >= ROWS or MapGenerator.map[(y + 1) * COLS + x] == MapGenerator.ROOM_TYPE.NONE:
				if MapGenerator.map[index] != MapGenerator.ROOM_TYPE.ENTRANCE:
					to_fill.append(1)
				else:
					var lobby_scene: Node2D = lobby.instantiate()
					lobby_scene.global_position = Vector2(x * 360.0, (y + 1) * 180.0)
					player.global_position = lobby_scene.global_position
					camera.global_position = lobby_scene.global_position
					add_child(lobby_scene)
					#print("Generated lobby (I believe)")
			if x - 1 < 0 or MapGenerator.map[y * COLS + x - 1] == MapGenerator.ROOM_TYPE.NONE:
				to_fill.append(2)
			if x + 1 >= COLS or MapGenerator.map[y * COLS + x + 1] == MapGenerator.ROOM_TYPE.NONE:
				to_fill.append(3)
			#print("Coordinates: ", Vector2i(x, y), " To fill: ", to_fill)
			
			add_child(room_scene)
			room_scene.fill_holes(to_fill)
			
			# Add book to finish room
			if MapGenerator.map[index] == MapGenerator.ROOM_TYPE.FINISH:
				room_scene.add_book()
			
			#print("Generated room (I hope)")


func enable_chromatic_aberration() -> void:
	chromatic_player.play("aberration")


func _on_room_changed(next_position: Vector2) -> void:
	camera.global_position = next_position
