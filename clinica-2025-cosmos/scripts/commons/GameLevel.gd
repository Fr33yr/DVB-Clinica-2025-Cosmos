extends Node2D

class_name LevelManager

@onready var player = $Player
@onready var projectile_container = $ProjectileContainer
@onready var area_2d = $Area2D

func _ready():
	player.projectile_shot.connect(_on_player_shot)

func _on_player_shot(projectile_scene, muzzle_position: Vector2, aim_angle: float, aim_direction: Vector2):
	var projectile: Projectile = projectile_scene.instantiate()
	projectile.direction = aim_direction
	projectile.global_position = muzzle_position
	projectile.rotation = aim_angle
	projectile_container.add_child(projectile)


func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		PlayerPowerUps.reset_powerups()
		get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")
