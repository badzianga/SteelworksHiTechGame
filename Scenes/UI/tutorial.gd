extends Control


var scrooling := false
var next_stop = 0.0


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot") and not scrooling:
		scrooling = true
		next_stop -= 180.0
	
	if scrooling:
		position.y -= 180 * delta

	if position.y < next_stop:
		position.y = next_stop
		scrooling = false
	
	if next_stop < -900.0:
		GameController.go_to_menu()
