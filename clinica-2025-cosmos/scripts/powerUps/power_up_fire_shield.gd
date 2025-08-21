extends PowerUp
class_name FireShield


@export var buff_duration: float = 4.0

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = buff_duration
	var instance = preload("res://scenes/projectiles/FireSpheresContainer.tscn").instantiate()
	player.add_child(instance)
	start()

func _process(_delta):
	if is_stopped():
		print("Fire shield Expired!")
		var fire_shperes_ref = player.get_node("FireSpheresContainer")
		fire_shperes_ref.queue_free()
		queue_free()
		
func _spawn_shield():
	pass
