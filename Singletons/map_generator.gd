extends Node


enum ROOM_TYPE {
	NONE,
	ENTRANCE,
	NORMAL,
	FINISH,
}

enum DIRECTIONS {
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

const ARRAY_ROWS := 5
const ARRAY_COLS := 5
const step := {
	DIRECTIONS.UP: -ARRAY_COLS,
	DIRECTIONS.DOWN: ARRAY_COLS,
	DIRECTIONS.LEFT: -1,
	DIRECTIONS.RIGHT: 1,
}

var map: Array[int]
var pointer: int


func _ready() -> void:
	map.resize(ARRAY_ROWS * ARRAY_COLS)
	clear_map()


func clear_map() -> void:
	print("Clearing map...")
	for i in range(ARRAY_ROWS * ARRAY_COLS):
		map[i] = ROOM_TYPE.NONE
	print("Cleared!")


func print_map() -> void:
	for i in range(ARRAY_ROWS * ARRAY_COLS):
		print(map[i])
		if i % ARRAY_COLS == ARRAY_COLS - 1:
			print("\n")


func generate(rooms: int) -> void:
	assert(rooms > 1)
	# set random entrance
	pointer = (ARRAY_ROWS - 1) * ARRAY_COLS + randi_range(0, ARRAY_COLS - 1)
	map[pointer] = ROOM_TYPE.ENTRANCE
	rooms -= 1
	
	while rooms > 0:
		create_next_room()
		rooms -= 1
	map[pointer] = ROOM_TYPE.FINISH


func create_next_room() -> void:
	var possible_directions: Array[DIRECTIONS] = []
	for key in step:
		var next_pointer: int = pointer + step[key]
		if next_pointer > 0 and next_pointer < ARRAY_COLS * ARRAY_ROWS:
			if map[next_pointer] == ROOM_TYPE.NONE:
				possible_directions.append(next_pointer)
	pointer = possible_directions.pick_random()
	map[pointer] = ROOM_TYPE.NORMAL


func at(row: int, col: int) -> int:
	return row * ARRAY_COLS + col
