extends Node2D

class_name PlayerShieldCardContainer

var player: Player

@export var radius: float = 120
@export var sphere_scene: PackedScene

@export var orbit_speed: float = 2.5
@export var cards: Array[PlayerShieldCard] = []

func _ready():
	pass
	#for i in range(cards.count(false)):
	#	var shpere = sphere_scene.instantiate()
	#	add_child(shpere)
	#	cards.append(shpere)
	#_update_shperes_positions(0.0)

func _process(delta) -> void:
	rotation += orbit_speed * delta
	#_update_shperes_positions(rotation)

func _update_shperes_positions(angle_offset: float)-> void:
	var step = TAU / cards.count(false)
	
	for i in range(cards.count(false)):
		var angle = angle_offset + step * i
		var pos = Vector2(
			cos(angle) * radius,
			sin(angle) * radius
		)
		cards[i].position = pos
