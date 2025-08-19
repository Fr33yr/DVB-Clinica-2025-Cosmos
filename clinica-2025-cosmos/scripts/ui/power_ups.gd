extends Control

@onready var other_pow_up = $OtherPowUp
@onready var current_pow_up = $CurrentPowUp

var current_power_up_res = Resource
var other_power_up_res = Resource

func _ready():
	PlayerPowerUps.connect("powerup_change", _on_power_up_change)

func _on_power_up_change(power_ups: Dictionary):
	print("power_ups in UI ", power_ups)
	
	var current_has_res = power_ups["current"].has("drop_sprite_path")
	var other_has_res = power_ups["other"].has("drop_sprite_path")
	
	if current_has_res and power_ups["other"].is_empty():
		var current_power_up_res = load(power_ups["current"]["drop_sprite_path"])
		current_pow_up.texture = current_power_up_res
		other_pow_up.texture = null
		
	if !current_has_res and !other_has_res:
		current_pow_up.texture = null
		other_pow_up.texture = null
	
	if current_has_res and other_has_res:
		var current_power_up_res = load(power_ups["current"]["drop_sprite_path"])
		var other_power_up_res = load(power_ups["other"]["drop_sprite_path"])
		current_pow_up.texture = current_power_up_res
		other_pow_up.texture = other_power_up_res
