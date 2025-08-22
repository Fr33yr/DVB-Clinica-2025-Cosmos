extends Node2D

class_name LevelManager

@onready var player = $Player
@onready var projectile_container = $ProjectileContainer
@onready var enemy_spawn_zone = $EnemySpawnZone

func _ready():
	player.projectile_shot.connect(_on_player_shot)
	enemy_spawn_zone.player = player

func _on_player_shot(projectile_scene, muzzle_position: Vector2, aim_angle: float, aim_direction: Vector2):
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.direction = aim_direction
	projectile.global_position = muzzle_position
	projectile.rotation = aim_angle
	projectile_container.add_child(projectile)
