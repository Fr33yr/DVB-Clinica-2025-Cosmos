extends Control

@onready var stick_right = $Stick_Right
@onready var stick_left = $Stick_Left

signal left_stick_drag(direction: Vector2)
signal right_stick_drag(direction: Vector2)

var viewport: Vector2

func _ready():
	viewport = get_viewport().size

func _input(event):
	# Touch start / end
	if event is InputEventScreenTouch and event.is_pressed():
		if event.pressed:
			print("Touch started at:", event.position)
		else:
			print("Touch ended at:", event.position)
	elif event is InputEventScreenDrag:
		if event.position.x < viewport.x / 2: # Left stick area
			var drag_direction: Vector2 = event.position - stick_left.global_position
			emit_signal("left_stick_drag", drag_direction.normalized())
		elif event.position.x >= viewport.x * 0.5: # Right stick area
			var drag_direction: Vector2 = event.position - stick_right.global_position
			emit_signal("right_stick_drag", drag_direction.normalized())
		else:
			print("outside")
	elif event is InputEventScreenTouch and not event.pressed:
		print("touch released")
		emit_signal("left_stick_drag", Vector2.ZERO)
		emit_signal("right_stick_drag", Vector2.ZERO)

		
