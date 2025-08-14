extends ProgressBar

class_name HPBar

@onready var hp_system = $"../HP_System"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	max_value = hp_system.hp_max
	value = max_value
	hp_system.damage_taken.connect(on_damage_taken)


func on_damage_taken(damage: int):
	if !visible:
		visible = true
	value -= damage
