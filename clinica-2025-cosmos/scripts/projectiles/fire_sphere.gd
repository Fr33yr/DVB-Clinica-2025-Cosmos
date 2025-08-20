extends Area2D

class_name PlayerFireShpere 

@export var damage: int = 1


func _on_area_entered(area):
	if area is Monster:
		print("Monster collided with fireball ")
