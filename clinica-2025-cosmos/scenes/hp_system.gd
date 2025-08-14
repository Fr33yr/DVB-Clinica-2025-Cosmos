extends Node

class_name HP_System

signal died
signal damage_taken(hp_current: int)
signal hp_restored(points: int)

var hp_max: int
var hp_current :int
var already_dead: bool = false

func init(total_hp: int):
	hp_max = total_hp
	hp_current = total_hp

func apply_damage(damage: int):
	hp_current = hp_current - damage
	damage_taken.emit(damage)
	if already_dead == false && hp_current <= 0:
		already_dead = true
		died.emit()

func restore_hp(restored_points: int):
	if hp_current < hp_max:
		hp_current = hp_current + restored_points
		hp_restored.emit(restored_points)
