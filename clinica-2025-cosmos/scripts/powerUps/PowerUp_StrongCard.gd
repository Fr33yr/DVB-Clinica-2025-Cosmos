extends PowerUp

class_name PowerUp_StrongCard

func _ready():
	duration = 10.0
	player.stronger_fire_mode = true
	player.stronger_fire_powerup = self
	super()

func _process(_delta):
	if !player.stronger_fire_mode:
		remove_powerUp()

func remove_powerUp():
	player.stronger_fire_mode = false
	super()
