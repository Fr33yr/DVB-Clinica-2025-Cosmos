extends Marker2D

@onready var player = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	look_at(player.global_position)
