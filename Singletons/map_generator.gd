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
const step: Array[Vector2i] = [
	Vector2i.UP,
	Vector2i.DOWN,
	Vector2i.LEFT,
	Vector2i.RIGHT,
]

var map: Array[ROOM_TYPE]
var pointer: Vector2i


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
	pointer.x = randi_range(0, ARRAY_COLS - 1)
	pointer.y = ARRAY_ROWS - 1
	map[at_v(pointer)] = ROOM_TYPE.ENTRANCE
	rooms -= 1
	
	while rooms > 0:
		create_next_room()
		rooms -= 1
	map[at_v(pointer)] = ROOM_TYPE.FINISH


func create_next_room() -> void:
	var possible_directions: Array[Vector2i] = []
	for i in range(4):
		var next_pointer := pointer + step[i]
		if next_pointer.x > 0 and next_pointer.x < ARRAY_COLS and next_pointer.y > 0 and next_pointer.y < ARRAY_ROWS:
			if map[at_v(next_pointer)] == ROOM_TYPE.NONE:
				possible_directions.append(next_pointer)
	if possible_directions.is_empty():
		# screw it, generate whole map if stuck
		# also create smaller map
		map.clear()
		map.resize(ARRAY_ROWS * ARRAY_COLS)
		clear_map()
		generate(6)
		return
	pointer = possible_directions.pick_random()
	map[at_v(pointer)] = ROOM_TYPE.NORMAL


func at(row: int, col: int) -> int:
	return row * ARRAY_COLS + col


func at_v(point: Vector2i) -> int:
	return point.y * ARRAY_COLS + point.x
