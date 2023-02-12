extends Node2D

var hidden = 0

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("left"):
		$Keys/L.hide()
	if Input.is_action_just_pressed("right"):
		$Keys/R.hide()
	if Input.is_action_just_pressed("jump"):
		$Keys/U.hide()
	if Input.is_action_just_pressed("down"):
		$Keys/D.hide()
	if Input.is_action_just_pressed("shoot"):
		$Keys/Z.hide()
	
	if !$Keys/L.visible and !$Keys/R.visible and !$Keys/U.visible and !$Keys/D.visible and !$Keys/Z.visible:
		get_tree().change_scene("res://level/Level.tscn")
	
