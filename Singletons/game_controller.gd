extends Node


var reputation_points := 10000
var glory_points := 10000
var player: Player
var ui: UI
var world: Node2D

signal room_changed(next_position: Vector2)

# State of user's weapons
var weapons = {
	"book": {
		"acquired": true,
		"level": 1,
		
		"damage": 10,
		"damage_multiplier": 1.5,
		"upgrade_cost": 21,
		"cost_multiplier": 1.1,
	},
	"gun": {
		"acquired": false,
		"level": 0,
		
		"damage": 70,
		"damage_multiplier": 1.5,
		"upgrade_cost": 90,
		"cost_multiplier": 1.2,
	},
	"laser_gun": {
		"acquired": false,
		"level": 0,
		
		"damage": 120,
		"damage_multiplier": 1.5,
		"upgrade_cost": 100,
		"cost_multiplier": 1.3,
	}
}

# User's abilities
var abilities = {
	"BAThesis": {
		"acquired": false,
		"cost": 150,
		"malfunction": 10, # 10%
	},
	"Beer": { # Dash
		"acquired": false,
		"cost": 350,
	},
	"Handshake": {
		"acquired": false,
		"cost": 700,
		"damage_multiplier": 1.05, # 5%
	},
	"Contract": {
		"acquired": false,
		"cost": 1500,
		"reload_multiplier": 0.9, # 10% faster
	},
}

@onready var music_player := $MusicPlayer


func _ready() -> void:
	randomize()


func reset_game() -> void:
	reputation_points = 0
	glory_points = 0
	player = null
	ui = null
	world = null
