extends Projectile

class_name PlayerBaseCard

var player: CharacterBody2D
var rotationSpeed: float

func _ready():
	super()
	player = $"../../Player"
	direction = player.aim_direction
	damage = 1
	speed = 2000
	rotationSpeed = 25

func _physics_process(delta):
	super(delta)
	rotation += rotationSpeed * delta

func _on_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Monster:
		destroy_projectile()
