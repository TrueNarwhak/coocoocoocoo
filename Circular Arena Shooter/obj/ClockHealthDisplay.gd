extends AnimatedSprite

export var max_frames = 8

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	pass
 
func damage():
	if frame != max_frames:
		frame += 1
