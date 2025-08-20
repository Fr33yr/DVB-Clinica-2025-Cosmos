extends Entity

class_name Monster

@onready var detector_area_2d = $Detector_Area2D
@onready var detector_collision_shape_2d = $PlayerDetector_Area2D/CollisionShape2D

@onready var hp_bar: HPBar = $HP_Bar

var chase_speed: float = 500

@onready var patrol_path: Array[Marker2D]
@onready var patrol_wait_time: float
var current_patrol_target: int
var wait_timer: float
var chasing: bool
var player: Player


# Initializes the HPSystem.
func _ready():
	super()
	hp_bar.max_value = hp_max
	hp_bar.value = hp_max
	hp_bar.visible = false

func _process(delta):
	if hp_system.hp_current < hp_system.hp_max:
		hp_bar.visible = true

func _physics_process(delta: float) -> void:
	if !chasing && patrol_path.size() > 1:
		move_along_path(delta)
	elif chasing:
		chase_player(delta)

# Calls to HPSystem to apply damage.
func apply_damage(damage_recieved: int):
	hp_system.apply_damage(damage_recieved)

func take_damage(damage_recieved: int) -> void:
	hp_bar.value -= damage_recieved

func _on_area_2d_area_entered(area: Area2D) -> void:
	var areaParent = area.get_parent()
	if areaParent is PlayerBaseCard:
		var damage_recieved = (areaParent as Projectile).damage
		hp_system.apply_damage(damage_recieved)

func move_along_path(delta: float):
	var target_position = patrol_path[current_patrol_target].global_position
	var direction = (target_position - position).normalized()
	var distance_to_target = position.distance_to(target_position)
	
	if distance_to_target > move_speed * delta:
		velocity = direction * move_speed
		move_and_slide()
	else:
		position = target_position
		wait_timer += delta
		if wait_timer >= patrol_wait_time:
			wait_timer = 0.0
			current_patrol_target = (current_patrol_target + 1) % patrol_path.size()
		

func chase_player(delta: float):
	var player_position = player.global_position
	var direction = (player_position - position).normalized()
	var distance_to_target = position.distance_to(player_position)
	
	if distance_to_target > chase_speed * delta:
		velocity = direction * move_speed
		move_and_slide()

# Disables all functions. Called from signal.
func on_Died():
	manage_drops()
	hp_bar.visible = false
	detector_area_2d.monitoring = false
	super()

func _on_monitoring_area_2d_area_entered(area):
	if area is PlayerBaseCard:
		var damage_recieved = area.damage
		hp_system.apply_damage(damage_recieved)
	elif area is PlayerFireShpere:
		var damage_recieved = (area as PlayerFireShpere).damage
		hp_system.apply_damage(damage_recieved)


func _on_detector_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		chasing = true
		player = areaParent


func _on_detector_area_2d_area_exited(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		chasing = false

func manage_drops():
	var numero = randi_range(1,10)
	var drop: StaticBody2D
	
	if numero == 1:
		drop = preload("res://scenes/drops/drop_strong_card.tscn").instantiate()
	if numero == 2:
		drop = preload("res://scenes/drops/drop_fire_shield.tscn").instantiate()
		
	if drop != null:
		drop.global_position = entity.global_position
		var container: Node = entity.get_parent()
		container.add_child(drop,false,Node.INTERNAL_MODE_DISABLED)
