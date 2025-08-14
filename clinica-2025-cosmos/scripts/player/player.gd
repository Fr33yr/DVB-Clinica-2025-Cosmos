extends Entity

class_name Player

signal projectile_shot

@onready var muzzle = $Muzzle
@onready var shooting_timer = $ShootingTimer

var friction : float = 1000

var stronger_fire_mode: bool = false
var rapid_fire_mode: bool = false
var rapid_fire_duration: float = 10.0

var fire_delay_normal: float = 0.2
var fire_delay_fast: float = 0.05

var character_direction : Vector2
var aim_direction : Vector2

var joystick_connected = false

# Initializes the HPSystem.
func _ready() -> void:
	check_connected_joypad()
	move_speed = 750
	hp_max = 3
	hp_system.init(hp_max)
	#TODO: HP Bar.
	hp_system.died.connect(on_Died)
	super()

func _process(delta):
	check_connected_joypad()
	movement_input()
	aiming_input()
	buttons_input()
	manage_shooting()
	manage_animation()
		
	if character_direction != Vector2.ZERO:
		velocity = character_direction.normalized() * move_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta) * Vector2.ZERO
	
	move_and_slide()

func check_connected_joypad():
	if Input.get_connected_joypads().size() > 0:
		joystick_connected = true
	else:
		joystick_connected = false

func movement_input():
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()

func aiming_input():
	if joystick_connected || Input.emulate_touch_from_mouse: #Use Joypad Input
		var aim_input = Vector2(Input.get_axis("aim_left", "aim_right"),
	 							Input.get_axis("aim_up", "aim_down"))
		aim_direction = aim_input.normalized()
		if aim_input.length() > 0.1 || aim_input.length() < -0.1: #Dead zone check
			$Muzzle.rotation = aim_input.angle()
			aim_direction = aim_input.normalized()
	else:
		var mouse_position = get_global_mouse_position()
		var muzzle_global_position = muzzle.global_position
		var direction = mouse_position - muzzle_global_position
		$Muzzle.rotation = direction.angle()
		aim_direction = direction.normalized()

func buttons_input():
	if Input.is_action_just_pressed("shuffle"):
		print("Shuffle!")
		
	if Input.is_action_just_pressed("powerup"):
		print("POWERUP!")

# Manages shooting time delay.
func manage_shooting():
	var firing: bool
	if aim_direction.x != 0 || aim_direction.y != 0:
		firing = true
	
	if firing && shooting_timer.is_stopped():
		if rapid_fire_mode == true:
			shooting_timer.start(fire_delay_fast)
			shoot()
		else:
			shooting_timer.start(fire_delay_normal)
			shoot()

# Manages projectile generation and type.
func shoot():
	if aim_direction == Vector2.ZERO: 
		pass
	var projectile = preload("res://scenes/projectiles/playerBaseCard.tscn")
	if stronger_fire_mode == true:
		projectile_shot.emit(projectile, muzzle.global_position)
	else:
		projectile_shot.emit(projectile, muzzle.global_position)

func manage_animation():
	pass

# Checks for contact with other objects. Verifies through class name.
func _on_monitorable_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Monster || areaParent is MonsterProjectile:
		var damage = (areaParent).damage
		hp_system.apply_damage(damage)

# Disables all functions. Called from signal.
func on_Died():
	set_process_input(false)
	set_physics_process(false)
	collision_shape_2d.set_deferred("disabled",true)
	collision_shape_2d.disabled = true
	monitorable_area_2d.monitoring = false
	monitoring_area_2d.monitorable = false
	sprite_2d.visible = false
	monitorable_collision_shape_2d.set_deferred("disabled",true)
	monitoring_collision_shape_2d.set_deferred("disabled",true)
	#get_tree().change_scene_to_file() #Either reset stage or send to lose screen
