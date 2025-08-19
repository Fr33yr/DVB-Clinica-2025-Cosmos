extends PowerUp
@onready var player_ref = $"../../.."

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.one_shot = true
	# TODO: Player buff
	start()

func _process(_delta):
	if is_stopped():
		print("Fire shield Expired!")
		# TODO: Expires
		queue_free()
