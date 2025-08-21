extends PowerUp

class_name PowerUp_Shield

var shield: PlayerShieldCardContainer

func _ready():
	if player.shield_card_mode && player.shield_powerup:
		player.shield_powerup.remove_powerUp()
	duration = 10.0
	shield = preload("res://scenes/projectiles/PlayerShieldCardContainer.tscn").instantiate()
	player.add_child(shield)
	shield.global_position = player.global_position
	player.shield_card_mode = true
	player.shield_powerup = self
	super()

func _process(_delta):
	if !player.shield_card_mode:
		remove_powerUp()

func _on_duration_timer_timeout():
	remove_powerUp()

func remove_powerUp():
	player.shield_card_mode = false
	shield.queue_free()
	super()
	
