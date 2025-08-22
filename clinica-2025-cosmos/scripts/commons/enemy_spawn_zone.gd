extends Node2D

class_name enemy_spawn_zone

var player: Player

@onready var spawn_area_2d = $SpawnArea2D
@onready var spawn_points = $SpawnPoints
@onready var spawn_delay_timer = $SpawnDelayTimer
@onready var zone_duration_timer = $ZoneDurationTimer

@export var enemy_spawners: Array[Marker2D] = []
@export var zone_duration: float
@export var spawn_delay: float

@onready var enemies_container = $EnemiesContainer

var already_activated: bool = false

func _ready():
	spawn_delay_timer.wait_time = spawn_delay
	zone_duration_timer.wait_time = zone_duration

func _on_spawn_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player && !already_activated:
		already_activated = true
		spawn_delay_timer.start()
		zone_duration_timer.start()
		spawn_enemies()

func _on_zone_duration_timer_timeout():
	spawn_delay_timer.stop()

func _on_spawn_delay_timer_timeout():
	spawn_enemies()

func spawn_enemies():
	var enemy0 = get_enemy_random()
	var enemy1 = get_enemy_random()
	var enemy2 = get_enemy_random()
	var enemy3 = get_enemy_random()
	var enemy4 = get_enemy_random()
	var enemy5 = get_enemy_random()
	
	enemy0.global_position = enemy_spawners[0].global_position
	enemy1.global_position = enemy_spawners[1].global_position
	enemy2.global_position = enemy_spawners[2].global_position
	enemy3.global_position = enemy_spawners[3].global_position
	enemy4.global_position = enemy_spawners[4].global_position
	enemy5.global_position = enemy_spawners[5].global_position
	
	enemy0.patrol_path.append(enemy0.global_position)
	enemy0.patrol_path.append(enemy0.global_position)
	enemy1.patrol_path.append(enemy1.global_position)
	enemy1.patrol_path.append(enemy1.global_position)
	enemy2.patrol_path.append(enemy2.global_position)
	enemy2.patrol_path.append(enemy2.global_position)
	enemy3.patrol_path.append(enemy3.global_position)
	enemy3.patrol_path.append(enemy3.global_position)
	enemy4.patrol_path.append(enemy4.global_position)
	enemy4.patrol_path.append(enemy4.global_position)
	enemy5.patrol_path.append(enemy5.global_position)
	enemy5.patrol_path.append(enemy5.global_position)
	
	enemies_container.add_child(enemy0)
	enemies_container.add_child(enemy1)
	enemies_container.add_child(enemy2)
	enemies_container.add_child(enemy3)
	enemies_container.add_child(enemy4)
	enemies_container.add_child(enemy5)

func get_enemy_random() -> Monster:
	var enemy: Monster
	var numero = randi_range(1,10)
	if numero<=5:
		enemy = preload("res://scenes/monsters/monsterAquatic.tscn").instantiate()
	elif numero >=6:
		enemy = preload("res://scenes/monsters/monster_cthul.tscn").instantiate()
	return enemy
