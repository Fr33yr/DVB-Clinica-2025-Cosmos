extends Node

signal powerup_change(slot: String, powerup: Dictionary)

var equiped_powerups: Dictionary = {
	"current": {},
	"other": {}
}

func _ready():
	pass

func powerup_collected(powerup: Dictionary):
	if !equiped_powerups["current"].is_empty() and !equiped_powerups["other"].is_empty():
		print("Inventory full")
	elif equiped_powerups["current"].is_empty() and equiped_powerups["other"].is_empty():
		equiped_powerups["current"] = powerup
		emit_signal("powerup_change", equiped_powerups)
		print("equiped_powerups",equiped_powerups)
	elif equiped_powerups["other"].is_empty():
		equiped_powerups["other"] = powerup
		emit_signal("powerup_change", equiped_powerups)
		print("",equiped_powerups)
	
func swap_powerup():
	var temp = equiped_powerups["current"]
	equiped_powerups["current"] = equiped_powerups["other"]
	equiped_powerups["other"] = temp
	emit_signal("powerup_change", equiped_powerups)
		
func use_powerup():
	equiped_powerups["current"] = equiped_powerups["other"]
	equiped_powerups["other"] = {}
