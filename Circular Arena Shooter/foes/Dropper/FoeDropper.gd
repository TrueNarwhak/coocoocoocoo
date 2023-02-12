extends Foe

export var spinny_speed = 7
export(PackedScene) var bomb

onready var spinny = $Spinny


# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	
	# Spinny
	spinny.rotation += spinny_speed * delta


func drop():
	var new_bomb = bomb.instance()
	new_bomb.position = position
	new_bomb.rotation = rotation
	get_tree().get_current_scene().add_child(new_bomb)

func _on_ActivationArea_body_entered(body):
	if body.is_in_group("Player"):
		call_deferred("drop")
