extends Area2D


func _on_area_entered(_area: Area2D) -> void:
	GameController.room_changed.emit(global_position)
