extends AnimationPlayer

export(String) var play_which

# ------------------------------------------------- #

func _ready():
	play(play_which)

func _process(delta):
	pass
 
