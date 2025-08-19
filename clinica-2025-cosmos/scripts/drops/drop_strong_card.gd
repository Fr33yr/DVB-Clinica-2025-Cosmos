extends Drop
class_name Drop_StrongCard
@onready var sprite = $Sprite2D

const POWER_UP_STRONG_CARD = preload("res://scenes/powerUps/PowerUp_StrongCard.tscn")

func _on_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		powerUp = PowerUp_StrongCard.new()
		PlayerPowerUps.powerup_collected({"powerUp": POWER_UP_STRONG_CARD,
		"drop_sprite_path": sprite.texture.resource_path})
		destroy_drop()

func _on_timer_timeout():
	super()
