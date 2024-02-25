extends Node


const MenuScene := preload("res://Scenes/UI/main_menu.tscn")
const WorldScene := preload("res://Scenes/Maps/world.tscn")
const ShopScene := preload("res://Scenes/UI/shop.tscn")

var reputation_points := 0
var glory_points := 0
var player: Player
var ui: UI
var world: Node2D
var current_wave := 0

signal room_changed(next_position: Vector2)

# State of user's weapons
const WEAPONS := {
	"book": {
		"acquired": true,
		"level": 1,
		
		"damage": 15,
		"damage_multiplier": 1.2,
		"upgrade_cost": 21,
		"cost_multiplier": 1.1,
		
		"title": "Hard Covered Math's Book",
		"description": "Ouch! That hurts. Upgrade your book to harden cover and deal more damage."
	},
	"gun": {
		"acquired": false,
		"level": 0,
		
		"damage": 40,
		"damage_multiplier": 1.2,
		"upgrade_cost": 90,
		"cost_multiplier": 1.2,
		
		"title": "Grandpa's Glock",
		"description": "It may be old, but sure deals a lot!"
	},
	"laser_gun": {
		"acquired": false,
		"level": 0,
		
		"damage": 70,
		"damage_multiplier": 1.2,
		"upgrade_cost": 100,
		"cost_multiplier": 1.3,
		
		"title": "UJ-knowledge-inator",
		"description": "Shoots with knowledge unbearable by UJ students. It's basic calculus..."
	}
}

var weapons := {}

# User's abilities
const ABILITIES := {
	"BAThesis": {
		"acquired": false,
		"cost": 150,
		"malfunction": 10, # 10%
		
		"title": "Bachelor of Arts Thesis",
		"description": "AGH carrying out an infiltration on UJ's students. 10% chance for drone malfanction due to UJ's students not graduating as a proper engeneers"
	},
	"Beer": { # Dash
		"acquired": false,
		"cost": 350,
		
		"title": "Beer for Flanki",
		"description": "Sudennly you gain speed abilities. Use [Space] to dash."
	},
	"Handshake": {
		"acquired": false,
		"cost": 700,
		"damage_multiplier": 1.05, # 5%
		
		"title": "Mrs Librarian's Handshake",
		"description": "You achieve boosted intelligence flow. Your damage is increased by 5%."
	},
	"Contract": {
		"acquired": false,
		"cost": 1500,
		"reload_multiplier": 0.9, # 10% faster
		
		"title": "Employment Contract",
		"description": "You gain confidence boost due to stable work and income as a student. 10% faster reloading"
	},
}

var abilities := {}

const wave_info := {
	1: {
		"enemies_in_room_min": 0,
		"enemies_in_room_max": 2,
		"time": 60,
	},
	2: {
		"enemies_in_room_min": 1,
		"enemies_in_room_max": 2,
		"time": 60,
	},
	3: {
		"enemies_in_room_min": 1,
		"enemies_in_room_max": 3,
		"time": 60,
	},
	4: {
		"enemies_in_room_min": 1,
		"enemies_in_room_max": 4,
		"time": 60,
	},
	5: {
		"enemies_in_room_min": 2,
		"enemies_in_room_max": 4,
		"time": 60,
	},
}

const health_multiplers := [
	1.0,
	1.1,
	1.3,
	1.5,
	2.0
]

func _ready() -> void:
	randomize()


func start_game() -> void:
	reset_game()
	go_to_world()


func go_to_menu() -> void:
	reset_game()
	get_tree().change_scene_to_packed(MenuScene)


func go_to_shop() -> void:
	get_tree().change_scene_to_packed(ShopScene)


func go_to_world() -> void:
	current_wave += 1
	get_tree().change_scene_to_packed(WorldScene)


func reset_game() -> void:
	weapons = WEAPONS.duplicate(true)
	abilities = ABILITIES.duplicate(true)
	reputation_points = 0
	glory_points = 0
	player = null
	ui = null
	world = null
	current_wave = 0
