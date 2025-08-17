extends Control

@onready var other_pow_up = $OtherPowUp
@onready var current_pow_up = $CurrentPowUp

var current_power_up_res = Resource
var other_power_up_res = Resource

func _ready():
	PlayerPowerUps.connect("powerup_change", _on_power_up_change)

func _on_power_up_change(power_ups: Dictionary):
	print("power_ups in UI ", power_ups)
	
	var current_has_res = power_ups["current"].has("res_path")
	var other_has_res = power_ups["other"].has("res_path")
	
	if current_has_res:
		var current_power_up_res = load(power_ups["current"]["res_path"])
		current_pow_up.texture = current_power_up_res
	
	if other_has_res:
		var other_power_up_res = load(power_ups["other"]["res_path"])
		other_pow_up.texture = other_power_up_res
