extends Timer

# ------------------------------------------------- #

func _ready():
	connect("timeout", self, "_on_timeout")

func _process(delta):
	pass
 
func _on_timeout():
	get_parent().set_collision_layer_bit(0, true)
	get_parent().set_collision_mask_bit(0, true)
