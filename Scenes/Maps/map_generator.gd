class_name MapGenerator
extends Node



const ARRAY_ROWS := 5
const ARRAY_COLS := 5

var map_array: Array[int]


func _ready() -> void:
	map_array.resize(ARRAY_ROWS * ARRAY_COLS)


func generate() -> void:
	pass


func at(row: int, col: int) -> int:
	return row * ARRAY_COLS + col
