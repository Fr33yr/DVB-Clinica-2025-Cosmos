extends Node

signal powerup_change(slot: String, powerup: Dictionary)

var current_power_up_container: Node
var other_power_up_container: Node

var equiped_powerups: Dictionary = {
	"current": {},
	"other": {}
}

func _process(delta):
	if Input.is_action_just_pressed("powerup"):
		use_powerup()
	if Input.is_action_just_pressed("swap"):
		swap_powerup()

func powerup_collected(powerup: Dictionary):
	if !equiped_powerups["current"].is_empty() and !equiped_powerups["other"].is_empty():
		print("Inventory full")
	elif equiped_powerups["current"].is_empty() and equiped_powerups["other"].is_empty():
		equiped_powerups["current"] = powerup
		emit_signal("powerup_change", equiped_powerups)
	elif equiped_powerups["other"].is_empty():
		equiped_powerups["other"] = powerup
		emit_signal("powerup_change", equiped_powerups)
	
func swap_powerup():
	if equiped_powerups["other"].is_empty() or equiped_powerups["current"].is_empty():
		print("cant swap one item")
	var temp = equiped_powerups["current"]
	equiped_powerups["current"] = equiped_powerups["other"]
	equiped_powerups["other"] = temp
	emit_signal("powerup_change", equiped_powerups)
		
func use_powerup():
	if equiped_powerups["current"].has("powerUp"):
		var instance: Node = equiped_powerups["current"]["powerUp"]
		if instance:
			print("instance exists ", instance)
			print("current power up ", current_power_up_container)
			current_power_up_container.add_child(instance)
			equiped_powerups["current"] = equiped_powerups["other"]
			equiped_powerups["other"] = {}
			emit_signal("powerup_change", equiped_powerups)
	elif equiped_powerups["other"].has("powerUp"):
		swap_powerup()
		use_powerup()

func reset_powerups():
	equiped_powerups = {
	"current": {},
	"other": {}
	}
	
	emit_signal("powerup_change", equiped_powerups)
