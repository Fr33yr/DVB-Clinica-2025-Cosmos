extends StaticBody2D

class_name Drop

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var area_2d = $Area2D
@onready var area_2d_collision_shape_2d = $Area2D/CollisionShape2D
@onready var timer = $Timer

var powerUp: PowerUp

func _ready():
	pass

func _on_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		destroy_drop()

func _on_timer_timeout():
	destroy_drop()

func destroy_drop():
	area_2d.monitoring = false
	area_2d.monitorable = false
	sprite_2d.visible = false
	area_2d_collision_shape_2d.set_deferred("disabled",true)
	collision_shape_2d.set_deferred("disabled",true)
	queue_free()
