extends Monster

class_name MonsterCthun

func _ready():
	hp_max = 3
	move_speed = 400
	chase_speed = 500
	super()

func handle_animations():
	if isDead():
		animated_sprite_2d.play("Dead")
	else:
		if chasing && player && player.global_position.distance_to(global_position)<= 200:
			animated_sprite_2d.play("Attack")
		elif velocity != Vector2.ZERO:
			animated_sprite_2d.play("Move")
		elif velocity == Vector2.ZERO:
			animated_sprite_2d.play("Idle")
		
