extends Node2D

var player_ref: Player
@export var radius: float = 120
@export var orbit_speed: float = 1.5
@export var sphere_count: int = 5
@export var sphere_scene: PackedScene

var spheres = []

func _ready():
	if not player_ref:
		player_ref = get_parent()
		
	for i in range(sphere_count):
		var shpere = sphere_scene.instantiate()
		add_child(shpere)
		spheres.append(shpere)
	_update_shperes_positions(0.0)

func _process(delta) -> void:
	rotation += orbit_speed * delta
	
	global_position = player_ref.global_position
	
	_update_shperes_positions(rotation)
	
func _update_shperes_positions(angle_offset: float)-> void:
	var step = TAU / sphere_count
	
	for i in range(sphere_count):
		var angle = angle_offset + step * i
		var pos = Vector2(
			cos(angle) * radius,
			sin(angle) * radius
		)
		spheres[i].position = pos
