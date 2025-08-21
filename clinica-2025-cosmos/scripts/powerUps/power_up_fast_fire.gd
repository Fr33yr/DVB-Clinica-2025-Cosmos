extends PowerUp
class_name PowerUp_FastFire


func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = player.rapid_fire_duration
	player.rapid_fire_mode = true
	start()

func _process(_delta):
	if is_stopped():
		print("RapidFire expired!")
		player.rapid_fire_mode = false
		queue_free()
