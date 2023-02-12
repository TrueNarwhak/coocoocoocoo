extends StaticBody2D

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	pass

func shape_state(_bool):
	$CollisionShape2D.disabled = _bool
