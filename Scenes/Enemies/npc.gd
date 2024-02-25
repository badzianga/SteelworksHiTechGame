extends CharacterBody2D

const sprites := [
	preload("res://Assets/Entities/Npc/npc_1.png"),
	preload("res://Assets/Entities/Npc/npc_2.png"),
	preload("res://Assets/Entities/Npc/npc_3.png"),
	preload("res://Assets/Entities/Npc/npc_4.png"),
]


func _ready() -> void:
	$Sprite.texture = sprites.pick_random()


func _on_detect_area_entered(_area: Area2D) -> void:
	print("Collected book: ", GameController.player.collected_book)
	if GameController.player.collected_book:
		GameController.finish_wave()
