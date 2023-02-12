extends Camera2D

export var rot_speed = 0.055

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	rotation_degrees = lerp(rotation_degrees, get_tree().get_current_scene().get_node("FacePlayerPoint").rotation_degrees - 90, rot_speed)
	pass
