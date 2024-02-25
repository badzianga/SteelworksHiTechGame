class_name Room
extends Node2D


const BookshelfScene := preload("res://Scenes/Environment/bookshelf.tscn")
const BookshelfTopScene := preload("res://Scenes/Environment/bookshelf_top.tscn")
const DroneScene := preload("res://Scenes/Enemies/drone.tscn")
const UJistScene := preload("res://Scenes/Enemies/ujist.tscn")

var visited := false

@onready var enemies := $Enemies


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
			1:
				var bookshelf1 := BookshelfScene.instantiate()
				bookshelf1.position = Vector2(-8, 96)
				add_child(bookshelf1)
				var bookshelf2 := BookshelfScene.instantiate()
				bookshelf2.position = Vector2(8, 96)
				add_child(bookshelf2)
			2:
				for y in range(-56, 24, 8):
					var bookshelf_top := BookshelfTopScene.instantiate()
					bookshelf_top.position = Vector2(-160.0, y)
					bookshelf_top.z_index = 2
					add_child(bookshelf_top)
			3:
				for y in range(-56, 24, 8):
					var bookshelf_top := BookshelfTopScene.instantiate()
					bookshelf_top.position = Vector2(160.0, y)
					bookshelf_top.z_index = 2
					add_child(bookshelf_top)


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


func _on_player_detection_area_area_entered(_area: Area2D) -> void:
	print("Visited? ", visited)
	if visited:
		return
	visited = true
	spawn_enemies()
