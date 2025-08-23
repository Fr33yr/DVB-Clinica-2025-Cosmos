extends Drop

class_name Drop_Restore_Vitality

@onready var sprite = $Sprite2D

func _on_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		destroy_drop()

func _on_timer_timeout():
	super()
