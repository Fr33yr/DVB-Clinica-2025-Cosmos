extends CharacterBody2D

@export var speed : float = 100

@export var left_stick : VirtualJoystick
@export var right_stick : VirtualJoystick

var aim_vector: float

func _process(delta):
	# Movement from left stick 
	var move_vector := Vector2.ZERO
	if left_stick and left_stick.is_pressed:
		move_vector = left_stick.output.normalized()
	position += move_vector * speed * delta

	# Rotation from right stick (aim)
	if right_stick and right_stick.is_pressed:
		rotation = right_stick.output.angle()


func _on_shuffle_pressed():
	print("Shuffle!")


func _on_power_up_pressed():
	print("PowerUp!")
