extends PowerUp
class_name PowerUp_SpreadCard

func _ready():
	duration = 10.0
	player.spread_card_mode = true
	player.spread_powerup = self
	super()
	
func remove_powerUp():
	player.spread_card_mode = false
	super()
