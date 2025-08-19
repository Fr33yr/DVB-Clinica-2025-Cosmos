extends Node
class_name PowerUp

var player: Player
var timer: Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true

func start(time: float = -1.0):
	if time > 0:
		timer.wait_time = time
	timer.start()

func is_stopped() -> bool:
	return timer.is_stopped()
