extends Node

signal powerup_change(slot: String, powerup: Dictionary)

var equiped_powerups: Dictionary = {
	"current": {},
	"other": {}
}

func _ready():
	pass

func _on_powerup_collected(powerup: Dictionary):
	if equiped_powerups["other"].is_empty:
		equiped_powerups["other"] = powerup
		emit_signal("powerup_change", equiped_powerups)
	
func swap_powerup():
	var temp = equiped_powerups["current"]
	equiped_powerups["current"] = equiped_powerups["other"]
	equiped_powerups["other"] = temp
		
func use_powerup():
	equiped_powerups["current"] = equiped_powerups["other"]
	equiped_powerups["other"] = {}
