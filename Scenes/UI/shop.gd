extends Node2D


const PopupScene := preload("res://Scenes/UI/popup.tscn")

var popup1: ColorRect = null
var popup2: ColorRect = null
var popup3: ColorRect = null
var popup4: ColorRect = null
var popup5: ColorRect = null
var popup6: ColorRect = null
var popup7: ColorRect = null


func _ready() -> void:
	set_points()


func _physics_process(_delta: float) -> void:
	# Weapons buying - using glory points 
	# book
	%Upgrade_1/progress.value = GameController.weapons["book"]["level"]
	%Upgrade_1/cost/Label.text = str(GameController.weapons["book"]["upgrade_cost"])
	
	# gun
	%Upgrade_2/progress.value = GameController.weapons["gun"]["level"]
	%Upgrade_2/cost/Label.text = str(GameController.weapons["gun"]["upgrade_cost"])
	
	# laser gun
	%Upgrade_3/progress.value = GameController.weapons["laser_gun"]["level"]
	%Upgrade_3/cost/Label.text = str(GameController.weapons["laser_gun"]["upgrade_cost"])
	
	# Abilities buying - using satisfaction points
	# BAThesis
	%Ability_1/cost/Label.text = str(GameController.abilities["BAThesis"]["cost"])
	%Ability_1.disabled = GameController.abilities["BAThesis"]["acquired"]
	
	# Beer
	%Ability_2/cost/Label.text = str(GameController.abilities["Beer"]["cost"])
	%Ability_2.disabled = GameController.abilities["Beer"]["acquired"]
	
	# Handshake
	%Ability_3/cost/Label.text = str(GameController.abilities["Handshake"]["cost"])
	%Ability_3.disabled = GameController.abilities["Handshake"]["acquired"]
	
	# Contract
	%Ability_4/cost/Label.text = str(GameController.abilities["Contract"]["cost"])
	%Ability_4.disabled = GameController.abilities["Contract"]["acquired"]


func set_points() -> void:
	$GloryPoints.text = str(GameController.glory_points)
	$ReputationPoints.text = str(GameController.reputation_points)


# Weapon upgrades =====================================================================
# Book - upgrade
func _on_btn_1_pressed() -> void:
	if GameController.glory_points > GameController.weapons["book"]["upgrade_cost"] and GameController.weapons["book"]["level"] < 12:
		GameController.glory_points -= GameController.weapons["book"]["upgrade_cost"]
		GameController.weapons["book"]["level"] += 1
		GameController.weapons["book"]["acquired"] = true
		GameController.weapons["book"]["upgrade_cost"] = round(GameController.weapons["book"]["upgrade_cost"] * GameController.weapons["book"]["cost_multiplier"])
		GameController.weapons["book"]["damage"] = round(GameController.weapons["book"]["damage"] * GameController.weapons["book"]["damage_multiplier"])
		set_points()

# Gun - upgrade
func _on_btn_2_pressed() -> void:
	if GameController.glory_points > GameController.weapons["gun"]["upgrade_cost"] and GameController.weapons["gun"]["level"] < 12:
		GameController.glory_points -= GameController.weapons["gun"]["upgrade_cost"]
		GameController.weapons["gun"]["level"] += 1
		GameController.weapons["gun"]["acquired"] = true
		GameController.weapons["gun"]["upgrade_cost"] = round(GameController.weapons["gun"]["upgrade_cost"] * GameController.weapons["gun"]["cost_multiplier"])
		GameController.weapons["gun"]["damage"] = round(GameController.weapons["gun"]["damage"] * GameController.weapons["gun"]["damage_multiplier"])
		set_points()

# Laser gun - upgrade
func _on_btn_3_pressed() -> void:
	if GameController.glory_points > GameController.weapons["laser_gun"]["upgrade_cost"] and GameController.weapons["laser_gun"]["level"] < 12:
		GameController.glory_points -= GameController.weapons["laser_gun"]["upgrade_cost"]
		GameController.weapons["laser_gun"]["level"] += 1
		GameController.weapons["laser_gun"]["acquired"] = true
		GameController.weapons["laser_gun"]["upgrade_cost"] = round(GameController.weapons["laser_gun"]["upgrade_cost"] * GameController.weapons["laser_gun"]["cost_multiplier"])
		GameController.weapons["laser_gun"]["damage"] = round(GameController.weapons["laser_gun"]["damage"] * GameController.weapons["laser_gun"]["damage_multiplier"])
		set_points()


# User Abilities ==============================================
func _on_ability_1_pressed() -> void:
	if GameController.reputation_points > GameController.abilities["BAThesis"]["cost"] and GameController.abilities["BAThesis"]["acquired"] == false:
		GameController.reputation_points -= GameController.abilities["BAThesis"]["cost"]
		GameController.abilities["BAThesis"]["acquired"] = true
		set_points()


func _on_ability_2_pressed() -> void:
	if GameController.reputation_points > GameController.abilities["Beer"]["cost"] and GameController.abilities["Beer"]["acquired"] == false:
		GameController.reputation_points -= GameController.abilities["Beer"]["cost"]
		GameController.abilities["Beer"]["acquired"] = true
		set_points()


func _on_ability_3_pressed() -> void:
	if GameController.reputation_points > GameController.abilities["Handshake"]["cost"] and GameController.abilities["Handshake"]["acquired"] == false:
		GameController.reputation_points -= GameController.abilities["Handshake"]["cost"]
		GameController.abilities["Handshake"]["acquired"] = true
		set_points()
		
		# Apply damage multiplier
		GameController.weapons["book"]["damage"] = round(GameController.weapons["book"]["damage"] * GameController.abilities["Handshake"]["damage_multiplier"])
		GameController.weapons["gun"]["damage"] = round(GameController.weapons["gun"]["damage"] * GameController.abilities["Handshake"]["damage_multiplier"])
		GameController.weapons["laser_gun"]["damage"] = round(GameController.weapons["laser_gun"]["damage"] * GameController.abilities["Handshake"]["damage_multiplier"])


func _on_ability_4_pressed() -> void:
	if GameController.reputation_points > GameController.abilities["Contract"]["cost"] and GameController.abilities["Contract"]["acquired"] == false:
		GameController.reputation_points -= GameController.abilities["Contract"]["cost"]
		GameController.abilities["Contract"]["acquired"] = true


func _on_btn_1_mouse_entered() -> void:
	popup1 = PopupScene.instantiate()
	popup1.set_texts(GameController.weapons["book"]["title"], GameController.weapons["book"]["description"])
	popup1.position = get_local_mouse_position() + Vector2(4.0, 4.0)
	add_child(popup1)


func _on_btn_2_mouse_entered() -> void:
	popup2 = PopupScene.instantiate()
	popup2.set_texts(GameController.weapons["gun"]["title"], GameController.weapons["gun"]["description"])
	popup2.position = get_local_mouse_position() + Vector2(4.0, 4.0)
	add_child(popup2)


func _on_btn_mouse_3_entered() -> void:
	popup3 = PopupScene.instantiate()
	popup3.set_texts(GameController.weapons["laser_gun"]["title"], GameController.weapons["laser_gun"]["description"])
	popup3.position = get_local_mouse_position() + Vector2(4.0, -56.0)
	add_child(popup3)


func _on_ability_1_mouse_entered() -> void:
	popup4 = PopupScene.instantiate()
	popup4.set_texts(GameController.abilities["BAThesis"]["title"], GameController.abilities["BAThesis"]["description"])
	popup4.position = get_local_mouse_position() + Vector2(-132.0, 4.0)
	add_child(popup4)


func _on_ability_2_mouse_entered() -> void:
	popup5 = PopupScene.instantiate()
	popup5.set_texts(GameController.abilities["Beer"]["title"], GameController.abilities["Beer"]["description"])
	popup5.position = get_local_mouse_position() + Vector2(-132.0, 4.0)
	add_child(popup5)


func _on_ability_3_mouse_entered() -> void:
	popup6 = PopupScene.instantiate()
	popup6.set_texts(GameController.abilities["Handshake"]["title"], GameController.abilities["Handshake"]["description"])
	popup6.position = get_local_mouse_position() + Vector2(-132.0, -32.0)
	add_child(popup6)


func _on_ability_4_mouse_entered() -> void:
	popup7 = PopupScene.instantiate()
	popup7.set_texts(GameController.abilities["Contract"]["title"], GameController.abilities["Contract"]["description"])
	popup7.position = get_local_mouse_position() + Vector2(-132.0, -32.0)
	add_child(popup7)


func _on_btn_1_mouse_exited() -> void:
	popup1.queue_free()


func _on_btn_2_mouse_exited() -> void:
	popup2.queue_free()


func _on_btn_3_mouse_exited() -> void:
	popup3.queue_free()


func _on_ability_1_mouse_exited() -> void:
	popup4.queue_free()


func _on_ability_2_mouse_exited() -> void:
	popup5.queue_free()


func _on_ability_3_mouse_exited() -> void:
	popup6.queue_free()


func _on_ability_4_mouse_exited() -> void:
	popup7.queue_free()


func _on_next_wave_pressed() -> void:
	GameController.go_to_world()
