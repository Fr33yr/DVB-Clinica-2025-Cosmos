extends Node

class_name PowerUp

var player: Player

@onready var duration_timer = $DurationTimer
@export var duration: float = 10.0

func _ready():
	duration_timer.one_shot = true
	duration_timer.start(duration)

func _on_duration_timer_timeout():
	remove_powerUp()

func remove_powerUp():
	queue_free()
