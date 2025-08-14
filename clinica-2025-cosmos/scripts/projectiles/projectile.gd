extends Area2D

class_name Projectile

@onready var exited_sreen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D 

@export var speed: float = 400
@export var direction: Vector2 = Vector2.ZERO
@export var damage: int = 10

var velocity: Vector2

func _ready():
	velocity = direction.normalized() * speed
	exited_sreen_notifier.screen_exited.connect(_on_screen_exited)
	
func _physics_process(delta):
	position += velocity * delta
	
func _on_screen_exited():
	queue_free()
