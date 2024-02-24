extends Node


var reputation_points := 0
var glory_points := 0
var player: Player
var ui: UI

@onready var music_player := $MusicPlayer


func _ready() -> void:
	randomize()


func reset_game() -> void:
	reputation_points = 0
	glory_points = 0
	player = null
	ui = null
