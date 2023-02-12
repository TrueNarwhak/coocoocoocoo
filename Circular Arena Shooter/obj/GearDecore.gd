extends Node2D

export var speed = 0.1
export var rotate = true

# ------------------------------------------------- #

func _ready():
	randomize()
	
	for child in get_children():
		child.modulate.a = rand_range(0.04, 0.12)
		child.rotation_degrees = rand_range(0, 360)

func _process(delta):
	for child in get_children():
		child.rotation += speed * delta
	
	if rotate:
		rotation = get_tree().get_current_scene().get_node("RotatingCam").rotation
		position = get_tree().get_current_scene().get_node("RotatingCam").position
	
