class_name Room
extends Node2D


const BookshelfScene := preload("res://Scenes/Environment/bookshelf.tscn")
const BookshelfTopScene := preload("res://Scenes/Environment/bookshelf_top.tscn")
const DroneScene := preload("res://Scenes/Enemies/drone.tscn")
const UJistScene := preload("res://Scenes/Enemies/ujist.tscn")

var visited := false

@onready var enemies := $Enemies
@onready var portals := $Portals


func fill_holes(directions: Array[int]):
	# I'm so, so sorry about that...
	for direction in directions:
		match direction:
			0:
				var bookshelf1 := BookshelfScene.instantiate()
				bookshelf1.position = Vector2(-8, -80)
				add_child(bookshelf1)
				var bookshelf2 := BookshelfScene.instantiate()
				bookshelf2.position = Vector2(8, -80)
				add_child(bookshelf2)
				portals.get_node("Portal0/CollisionShape").set_deferred("disabled", true)
			1:
				var bookshelf1 := BookshelfScene.instantiate()
				bookshelf1.position = Vector2(-8, 96)
				add_child(bookshelf1)
				var bookshelf2 := BookshelfScene.instantiate()
				bookshelf2.position = Vector2(8, 96)
				add_child(bookshelf2)
				portals.get_node("Portal1/CollisionShape").set_deferred("disabled", true)
			2:
				for y in range(-56, 24, 8):
					var bookshelf_top := BookshelfTopScene.instantiate()
					bookshelf_top.position = Vector2(-160.0, y)
					bookshelf_top.z_index = 2
					add_child(bookshelf_top)
				portals.get_node("Portal2/CollisionShape").set_deferred("disabled", true)
			3:
				for y in range(-56, 24, 8):
					var bookshelf_top := BookshelfTopScene.instantiate()
					bookshelf_top.position = Vector2(160.0, y)
					bookshelf_top.z_index = 2
					add_child(bookshelf_top)
				portals.get_node("Portal3/CollisionShape").set_deferred("disabled", true)


func spawn_enemies() -> void:
	var spawn_points := $SpawnPoints.get_children()
	var low: int = GameController.wave_info[GameController.current_wave]["enemies_in_room_min"]
	var high: int = GameController.wave_info[GameController.current_wave]["enemies_in_room_max"]
	var amount := randi_range(low, high)
	for _i in range(amount):
		var enemy: CharacterBody2D
		if randf() < 0.5:
			enemy = DroneScene.instantiate()
		else:
			enemy = UJistScene.instantiate()
		var spawn_point: Marker2D = spawn_points.pick_random()
		spawn_points.erase(spawn_point)
		enemy.position = spawn_point.position
		enemies.call_deferred("add_child", enemy)


func add_book() -> void:
	var book_points := $BookPoints.get_children()
	var point: Marker2D = book_points.pick_random()
	var book_area: Area2D = load("res://Scenes/Environment/book_area.tscn").instantiate()
	book_area.global_position = point.global_position
	GameController.world.add_child(book_area)


func _on_player_detection_area_area_entered(_area: Area2D) -> void:
	#print("Visited? ", visited)
	if visited:
		return
	visited = true
	spawn_enemies()
