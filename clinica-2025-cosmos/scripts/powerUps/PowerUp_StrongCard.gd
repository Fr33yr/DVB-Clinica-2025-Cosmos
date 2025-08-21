extends PowerUp
class_name PowerUp_StrongCard

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = player.stronger_fire_duration
	player.stronger_fire_mode = true
	start()

func _process(_delta):
	if is_stopped():
		print("stopped")
		player.stronger_fire_mode = false
		queue_free()
