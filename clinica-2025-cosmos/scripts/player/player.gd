extends Entity

class_name Player

signal projectile_shot

@onready var muzzle = $Muzzle
@onready var shooting_timer = $ShootingTimer
@onready var current_power_up = $PowerUpsContainer/CurrentPowerUp
@onready var other_power_up = $PowerUpsContainer/OtherPowerUp

@onready var shoot_sfx = $Shoot_SFX
@onready var drop_card_pick_up_sfx = $DropCardPickUp_SFX

var friction : float = 1000

var stronger_fire_powerup: PowerUp_StrongCard = null
var rapid_fire_powerup: PowerUp_RapidFire = null
var shield_powerup: PowerUp_Shield = null
var spread_powerup: PowerUp_SpreadCard = null

var stronger_fire_mode: bool = false
var rapid_fire_mode: bool = false
var shield_card_mode: bool = false
var spread_card_mode: bool = false

var fire_delay_normal: float = 0.15
var fire_delay_fast: float = 0.07

var character_direction : Vector2
var aim_direction : Vector2

var joystick_connected = false

# Initializes the HPSystem.
func _ready() -> void:
	PlayerPowerUps.current_power_up_container = current_power_up
	PlayerPowerUps.other_power_up_container = other_power_up
	check_connected_joypad()
	move_speed = 750
	hp_max = 5
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
	pass


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
	var projectile_path: String
	if stronger_fire_mode == true:
		projectile_path = PathToProjectiles.playerStrongCard
	else:
		projectile_path = PathToProjectiles.playerBaseCard
	if spread_card_mode:
		manage_spread(projectile_path)
	else:
		var aim_angle = muzzle.rotation + deg_to_rad(90)
		var muzzle_position = muzzle.global_position
		var projectile_instance = load(projectile_path)
		projectile_shot.emit(projectile_instance, muzzle_position, aim_angle, aim_direction)
		shoot_sfx.play()
	
func manage_spread(path: String):
	var projectile_1 = load(path)
	var projectile_2 = load(path)
	var projectile_3 = load(path)
	var aim_angle_1 = muzzle.rotation + deg_to_rad(65)
	var aim_angle_2 = muzzle.rotation + deg_to_rad(90)
	var aim_angle_3 = muzzle.rotation + deg_to_rad(115)
	var muzzle_position = muzzle.global_position 
	var aim_direction_1 = aim_direction.rotated(deg_to_rad(-35)) 
	var aim_direction_2 = aim_direction 
	var aim_direction_3 = aim_direction.rotated(deg_to_rad(35))  
	projectile_shot.emit(projectile_1, muzzle_position, aim_angle_1, aim_direction_1)
	projectile_shot.emit(projectile_2, muzzle_position, aim_angle_2, aim_direction_2)
	projectile_shot.emit(projectile_3, muzzle_position, aim_angle_3, aim_direction_3)
	shoot_sfx.play()
	shoot_sfx.play()
	shoot_sfx.play()

func manage_animation():
	pass

# Disables all functions. Called from signal.
func on_Died():
	set_process_input(false)
	set_physics_process(false)
	collision_shape_2d.set_deferred("disabled",true)
	collision_shape_2d.disabled = true
	monitorable_area_2d.monitoring = false
	monitoring_area_2d.monitorable = false
	animated_sprite_2d.visible = false
	monitorable_collision_shape_2d.set_deferred("disabled",true)
	monitoring_collision_shape_2d.set_deferred("disabled",true)
	get_tree().reload_current_scene()

func _on_monitoring_area_2d_area_entered(area):
	var areaParent = area.get_parent()
	if areaParent is Monster || areaParent is MonsterProjectile:
		var damage = areaParent.damage
		hp_system.apply_damage(damage)
	elif areaParent is Drop:
		drop_card_pick_up_sfx.play()
