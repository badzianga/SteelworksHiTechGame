extends Area2D


func _on_area_entered(_area: Area2D) -> void:
	GameController.player.collected_book = true
	queue_free()
