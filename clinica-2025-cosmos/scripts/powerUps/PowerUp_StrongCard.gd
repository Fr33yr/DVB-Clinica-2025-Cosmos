extends PowerUp

class_name PowerUp_StrongCard

func _ready():
	one_shot = true
	wait_time = player.stronger_fire_duration
	player.stronger_fire_mode = true
	start()

func _process(delta):
	if is_stopped():
		player.stronger_fire_mode = false
		queue_free()
