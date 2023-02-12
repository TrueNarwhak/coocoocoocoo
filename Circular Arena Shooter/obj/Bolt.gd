extends Node2D

# ------------------------------------------------- #

func _ready():
	get_tree().get_current_scene().get_node("Player").connect("update_health_dispaly", self, "_on_update_health_dispaly")

func _process(delta):
	rotation_degrees = get_tree().get_current_scene().get_node("RotatingCam").rotation_degrees
 
func _on_update_health_dispaly(new_hp):
	print("im out of shit to say")
	
	$HPText.text = str(new_hp)
	$Health.frame += 1
