extends Projectile

class_name PlayerBaseCard

var player: CharacterBody2D

func _ready():
	super()
	player = $"../../Player"
	direction = player.aim_direction
	damage = 1
	speed = 2000
	

func _on_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Monster || areaParent is MonsterProjectile:
		destroy_projectile()
