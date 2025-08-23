extends CanvasLayer

@onready var right_stick = $Control/RightStick
@onready var left_stick = $Control/LeftStick
@onready var power_ups = $Control/PowerUps
@onready var player_hp_bar = $Control/PlayerHPBar

@export var player: Player

func _ready():
	player_hp_bar.init(player.hp_system)
