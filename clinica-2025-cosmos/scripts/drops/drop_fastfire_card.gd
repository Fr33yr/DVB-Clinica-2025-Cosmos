extends Drop

class_name Drop_FastFire

@onready var sprite = $Sprite2D

func _on_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		var powerUp: PowerUp = preload("res://scenes/powerUps/PowerUp_RapidFire.tscn").instantiate()
		powerUp.player = areaParent
		PlayerPowerUps.powerup_collected({
		"powerUp": powerUp,
		"drop_sprite_path": sprite.texture.resource_path
		})
		destroy_drop()

func _on_timer_timeout():
	super()
