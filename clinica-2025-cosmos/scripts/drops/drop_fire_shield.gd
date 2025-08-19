extends Drop

class_name Drop_Fire_Shield
@onready var sprite = $Sprite2D

func _on_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		powerUp = PowerUp_StrongCard.new()
		powerUp.player = areaParent
		areaParent.add_child(powerUp, false, Node.INTERNAL_MODE_DISABLED)
		PlayerPowerUps.powerup_collected({"name":"Drop_FireShield",
		"res_path": sprite.texture.resource_path})
		destroy_drop()

func _on_timer_timeout():
	super()
