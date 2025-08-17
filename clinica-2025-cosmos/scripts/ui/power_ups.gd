extends Control

@onready var other_pow_up = $OtherPowUp
@onready var current_pow_up = $CurrentPowUp

var image_01 = load("res://assets/Icons/energy_cell.png")
var image_02 = load("res://assets/Icons/shield_cell.png")

func _ready():
	other_pow_up.texture = image_02
	current_pow_up.texture = image_01

func _on_power_up_pressed():
	pass # Replace with function body.

func _on_switch_pow_up_pressed():
	current_pow_up.texture = image_02
	other_pow_up.texture = image_01
