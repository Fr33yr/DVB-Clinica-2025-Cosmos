extends Projectile

class_name MonsterProjectile

@onready var rotationSpeed: float

func _ready():
	super()
	damage = 1
	speed = 400
	rotationSpeed = 25.0

func _physics_process(delta):
	super(delta)
	rotation += rotationSpeed * delta

func _on_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player || areaParent is PlayerBaseCard:
		print("Collision with", areaParent)
		destroy_projectile()


func _on_visible_on_screen_notifier_2d_screen_exited():
	super()
