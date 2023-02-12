extends Position2D

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	look_at(get_parent().get_node("Player").position)
