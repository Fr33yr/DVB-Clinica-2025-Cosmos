extends Area2D

class_name Projectile

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D 

@export var speed: float
@export var direction: Vector2
@export var damage: int

var velocity: Vector2

func _ready():
	visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exited)
	
func _physics_process(delta):
	velocity = direction.normalized() * speed
	position += velocity * delta
	
func _on_screen_exited():
	destroy_projectile()

func destroy_projectile():
	# Disable children nodes!!!
	#await get_tree().create_timer(0.07).timeout
	queue_free()
