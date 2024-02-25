extends Area2D


@export var jump_direction: Vector2


func _on_area_entered(_area: Area2D) -> void:
	if jump_direction == Vector2.UP:
		GameController.player.global_position.y -= 80.0
	elif jump_direction == Vector2.DOWN:
		GameController.player.global_position.y += 80.0
	elif jump_direction == Vector2.LEFT:
		GameController.player.global_position.x -= 80.0
	elif jump_direction == Vector2.RIGHT:
		GameController.player.global_position.x += 80.0
