extends Node2D

export(String) var link
var can_click = false

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	if can_click and Input.is_action_just_pressed("click"):
		OS.shell_open(link)


func _on_Discord_mouse_entered():
	get_node("Outline").visible = true
	can_click = true


func _on_Discord_mouse_exited():
	get_node("Outline").visible = false
	can_click = false
