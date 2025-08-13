extends CharacterBody2D


var move_direction :Vector2
var aim_direction :Vector2
var speed = 600


func _physics_process(delta):
	velocity = move_direction * speed
	move_and_slide()

func _on_control_left_stick_drag(direction):
	if direction != Vector2.ZERO:
		rotation = direction.angle()


func _on_control_right_stick_drag(direction):
	move_direction = direction
