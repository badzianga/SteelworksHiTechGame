extends Area2D

@export var room_type := 0


func _on_area_entered(_area: Area2D) -> void:
	if room_type == 1: # lobby
		if not GameController.lobby_music.playing:
			GameController.lobby_music.play()
			GameController.library_music.stop()
	else:
		if not GameController.library_music.playing:
			GameController.lobby_music.stop()
			GameController.library_music.play()
	GameController.room_changed.emit(global_position)
