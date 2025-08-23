extends Monster

class_name MonsterAquatic

@onready var shooting_timer = $ShootingTimer
var isVisible: bool = false

func _ready():
	hp_max = 3
	super()

func _on_shooting_timer_timeout():
	if  player != null && isVisible:
		var player_position = player.global_position
		var direction = (player_position - position).normalized()
		var orb = preload("res://scenes/projectiles/monsterProjectile.tscn").instantiate()
		
		orb.global_position = entity.global_position
		orb.direction = direction
		
		var container: Node = entity.get_parent()
		
		container.add_child(orb)

func handle_animations():
	if isDead():
		animated_sprite_2d.play("Dead")
	else:
		if velocity == Vector2.ZERO:
			animated_sprite_2d.play("Idle")
		else:
			animated_sprite_2d.play("Move")

func _on_monitoring_area_2d_area_entered(area):
	super(area)


func _on_detector_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Player:
		chasing = true
		player = areaParent


func _on_visible_on_screen_notifier_2d_screen_entered():
	isVisible = true


func _on_visible_on_screen_notifier_2d_screen_exited():
	isVisible = false
