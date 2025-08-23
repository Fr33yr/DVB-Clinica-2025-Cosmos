extends Control

class_name PlayerHPBar

@onready var hp_bar = $HP_Bar
var hp_system: HP_System

# Called when the node enters the scene tree for the first time.
func init(hp_system):
	self.hp_system = hp_system
	hp_bar.max_value = hp_system.hp_max
	hp_bar.value = hp_bar.max_value
	hp_system.damage_taken.connect(on_damage_taken)


func on_damage_taken(damage: int):
	hp_bar.value -= damage
