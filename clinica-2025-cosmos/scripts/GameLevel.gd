extends Node2D

class_name GameLevel

@onready var player = $Player
@onready var projectile_container = $ProjectileContainer

func _ready():
	player.projectile_shot.connect(_on_player_bubble_shot) 

func _on_player_bubble_shot(bubble_scene, location):
	var bubble = bubble_scene.instantiate()
	bubble.global_position = location
	projectile_container.add_child(bubble)
