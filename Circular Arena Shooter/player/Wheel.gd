extends Sprite

export var speed = 18

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	rotation += speed * int(get_parent().get_parent().x_input) * delta
#	speed = lerp(speed, int(get_parent().get_parent().x_input), 0.2)
 
