extends PlayerBaseCard

class_name PlayerStrongCard

func _ready():
	super()
	damage = 3

func _on_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Monster:
		destroy_projectile()
