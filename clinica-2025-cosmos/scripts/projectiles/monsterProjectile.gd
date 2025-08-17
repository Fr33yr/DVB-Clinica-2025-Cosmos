extends Projectile

class_name MonsterProjectile

func _ready():
	super()
	damage = 1
	speed = 250

func _on_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player || areaParent is PlayerBaseCard:
		destroy_projectile()
