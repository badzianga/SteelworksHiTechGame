extends Node


var reputation_points := 0
var glory_points := 0
var player: CharacterBody2D


func reset_game() -> void:
	reputation_points = 0
	glory_points = 0
	player = null
