extends Area2D

# ------------------------------------------------- #

func _ready():
	connect("body_entered", self, "_on_SquishBox_body_entered")
	$OnTimer.connect("timeout", self, "_on_OnTimer_timeout")

func _process(delta):
	pass
 

func _on_SquishBox_body_entered(body):
	if body.is_in_group("Ground"):
		get_parent().get_node("Sprite").scale = Vector2(0.6, 0.2)
		$SlamSFX.advanced_play()

func _on_OnTimer_timeout():
	set_collision_layer_bit(2, true)
	set_collision_mask_bit(2, true)
