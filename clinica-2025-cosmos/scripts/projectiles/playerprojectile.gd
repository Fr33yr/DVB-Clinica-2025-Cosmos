extends Projectile

class_name PlayerBasicCard

var player: CharacterBody2D

func _ready():
	player = $"../../Player"
	direction = player.aim_direction
	speed = 1500
	damage = 1

func _physics_process(delta):
	velocity = direction * speed
	position += velocity * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy_bubble()

func destroy_bubble():
	# Disable children nodes!!!
	#await get_tree().create_timer(0.07).timeout
	queue_free()
