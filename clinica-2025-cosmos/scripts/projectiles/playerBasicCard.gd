extends Projectile

class_name PlayerBaseCard

var player: CharacterBody2D

func _ready():
	super()
	player = $"../../Player"
	direction = player.aim_direction
	speed = 2000
