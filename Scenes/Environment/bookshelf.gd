extends StaticBody2D



func _on_alpha_area_area_entered(area):
	modulate.a = 0.4


func _on_alpha_area_area_exited(area):
	modulate.a = 1
