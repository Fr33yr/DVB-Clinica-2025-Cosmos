extends PowerUp

class_name PowerUp_RapidFire


func _ready():
	duration = 10.0
	player.rapid_fire_mode = true
	player.rapid_fire_powerup = self
	super()

func remove_powerUp():
	player.rapid_fire_mode = false
	super()
