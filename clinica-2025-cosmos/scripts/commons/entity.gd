extends CharacterBody2D

class_name Entity

@onready var entity = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var monitoring_area_2d = $Monitoring_Area2D
@onready var monitoring_collision_shape_2d = $Monitoring_Area2D/CollisionShape2D
@onready var monitorable_area_2d = $Monitorable_Area2D
@onready var monitorable_collision_shape_2d = $Monitorable_Area2D/CollisionShape2D

@onready var hp_system: HP_System = $HP_System

var damage: int = 1
var hp_max: int

var move_speed: float = 100

# Initializes the HPSystem.
func _ready():
	hp_system.init(hp_max)
	hp_system.died.connect(on_Died)


# Calls to HPSystem to apply damage.
func apply_damage(damage_recieved: int):
	hp_system.apply_damage(damage_recieved)


# Disables all functions. Called from signal.
func on_Died():
	collision_shape_2d.set_deferred("disabled",true)
	collision_shape_2d.disabled = true
	monitorable_area_2d.monitoring = false
	monitoring_area_2d.monitorable = false
	animated_sprite_2d.visible = false
	monitorable_collision_shape_2d.set_deferred("disabled",true)
	monitoring_collision_shape_2d.set_deferred("disabled",true)
	queue_free()
