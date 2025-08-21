extends Node2D

class_name LevelManager

@onready var player = $Player
@onready var projectile_container = $ProjectileContainer

func _ready():
	player.projectile_shot.connect(_on_player_shot) 

func _on_player_shot(projectile_scene, muzzle_position: Vector2, aim_angle: float):
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.global_position = muzzle_position
	projectile.rotation = aim_angle
	projectile_container.add_child(projectile)
