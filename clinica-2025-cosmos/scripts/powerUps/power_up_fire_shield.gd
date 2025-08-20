extends PowerUp
class_name FireShield

@onready var player_ref = $"../../.."

const FIRE_SPHERES_CONTAINER = preload("res://scenes/projectiles/FireSpheresContainer.tscn")

@export var buff_duration: float = 4.0

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.wait_time = buff_duration
	var instance = FIRE_SPHERES_CONTAINER.instantiate()
	player_ref.add_child(instance)
	start()

func _process(_delta):
	if is_stopped():
		print("Fire shield Expired!")
		var fire_shperes_ref = player_ref.get_node("FireSpheresContainer")
		fire_shperes_ref.queue_free()
		queue_free()
		
func _spawn_shield():
	pass
