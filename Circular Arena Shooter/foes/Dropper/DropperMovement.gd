extends Node

const FPS = 60

export var distance_from_point = 200
export var speed = 0.25

onready var point = get_tree().get_current_scene().get_node("CenterPoint")
var dir = 1

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	get_parent().position.x = point.position.x + (distance_from_point * cos(deg2rad(get_parent().rotation_degrees)));
	get_parent().position.y = point.position.y + (distance_from_point * sin(deg2rad(get_parent().rotation_degrees)));
	
	get_parent().rotation_degrees += (speed * dir) * delta * FPS
