extends Node2D

# Weapon upgrades =========================================
# Upgrade costs
var cost_1 = GameController.weapons["book"]["upgrade_cost"]
var cost_2 = GameController.weapons["gun"]["upgrade_cost"]
var cost_3 = GameController.weapons["laser_gun"]["upgrade_cost"]

# Upgrade points
var lvl_1 = GameController.weapons["book"]["level"]
var lvl_2 = GameController.weapons["gun"]["level"]
var lvl_3 = GameController.weapons["laser_gun"]["level"]

# Damage points
var damage_1 = GameController.weapons["book"]["damage"]
var damage_2 = GameController.weapons["gun"]["damage"]
var damage_3 = GameController.weapons["laser_gun"]["damage"]

# Abilities ================================================
# Abilities cost
var a_cost_1 = GameController.abilities["BAThesis"]["cost"]
var a_cost_2 = GameController.abilities["Beer"]["cost"]
var a_cost_3 = GameController.abilities["Handshake"]["cost"]
var a_cost_4 = GameController.abilities["Contract"]["cost"]

# Acquirance status of ability
var has_1 = GameController.abilities["BAThesis"]["acquired"]
var has_2 = GameController.abilities["Beer"]["acquired"]
var has_3 = GameController.abilities["Handshake"]["acquired"]
var has_4 = GameController.abilities["Contract"]["acquired"]

func _physics_process(delta):
	
	# Weapons buying - using glory points 
	# book
	%Upgrade_1/progress.value = lvl_1
	%Upgrade_1/cost/Label.text = str(cost_1)
	
	# gun
	%Upgrade_2/progress.value = lvl_2
	%Upgrade_2/cost/Label.text = str(cost_2)
	
	# laser gun
	%Upgrade_3/progress.value = lvl_3
	%Upgrade_3/cost/Label.text = str(cost_3)
	
	# Abilities buying - using satisfaction points
	# BAThesis
	%Ability_1/cost/Label.text = str(a_cost_1)
	%Ability_1.disabled = has_1
	
	# Beer
	%Ability_2/cost/Label.text = str(a_cost_2)
	%Ability_2.disabled = has_2
	
	# Handshake
	%Ability_3/cost/Label.text = str(a_cost_3)
	%Ability_3.disabled = has_3
	
	# Contract
	%Ability_4/cost/Label.text = str(a_cost_4)
	%Ability_4.disabled = has_4

# Weapon upgrades =====================================================================
# Book - upgrade
func _on_btn_1_pressed():
	if GameController.glory_points > cost_1 and lvl_1 < 12:
		GameController.glory_points -= cost_1
		lvl_1 += 1
		cost_1 = round(cost_1 * GameController.weapons["book"]["cost_multiplier"])
		damage_1 = round( damage_1 * GameController.weapons["book"]["damage_multiplier"])

# Gun - upgrade
func _on_btn_2_pressed():
	if GameController.glory_points > cost_2 and lvl_2 < 12:
		GameController.glory_points -= cost_2
		lvl_2 += 1
		cost_2 = round(cost_2 * GameController.weapons["gun"]["cost_multiplier"])
		damage_2 = round( damage_2 * GameController.weapons["gun"]["damage_multiplier"])

# Laser gun - upgrade
func _on_btn_3_pressed():
	if GameController.glory_points > cost_3 and lvl_3 < 12:
		GameController.glory_points -= cost_3
		lvl_3 += 1
		cost_3 = round(cost_3 * GameController.weapons["laser_gun"]["cost_multiplier"])
		damage_3 = round( damage_3 * GameController.weapons["laser_gun"]["damage_multiplier"])


# User Abilities ==============================================
func _on_ability_1_pressed():
	if GameController.reputation_points > a_cost_1 and has_1 == false:
		GameController.reputation_points -= a_cost_1
		has_1 = true


func _on_ability_2_pressed():
	if GameController.reputation_points > a_cost_2 and has_2 == false:
		GameController.reputation_points -= a_cost_2
		has_2 = true


func _on_ability_3_pressed():
	if GameController.reputation_points > a_cost_3 and has_3 == false:
		GameController.reputation_points -= a_cost_3
		has_3 = true
		
		# Apply damage multiplier
		damage_1 = round( damage_1 * GameController.abilities["Handshake"]["damage_multiplier"])
		damage_2 = round( damage_2 * GameController.abilities["Handshake"]["damage_multiplier"])
		damage_3 = round( damage_3 * GameController.abilities["Handshake"]["damage_multiplier"])


func _on_ability_4_pressed():
	if GameController.reputation_points > a_cost_4 and has_4 == false:
		GameController.reputation_points -= a_cost_4
		has_4 = true
