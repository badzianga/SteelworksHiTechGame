extends Node2D


func _on_start_button_pressed() -> void:
	GameController.start_game()


func _on_exit_button_pressed() -> void:
	get_tree().quit()
