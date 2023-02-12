extends Node

const FPS = 60

export var distance_from_point:int
export var speed = 0.5

onready var point = get_tree().get_current_scene().get_node("CenterPoint")
var dir = 1
var time:float

# ------------------------------------------------- #

func _ready():
	get_parent().visible = false

func _process(delta):
	get_parent().position.x = point.position.x + (distance_from_point * cos(deg2rad(get_parent().rotation_degrees)))
	get_parent().position.y = point.position.y + (distance_from_point * sin(deg2rad(get_parent().rotation_degrees)))
	
	get_parent().rotation_degrees += (speed * dir) * delta * FPS
	
	time += delta
	distance_from_point = 220 + return_sine(2,100) 
	
	# Sprite Rotation
#	get_parent().get_node("Sprite/Holder")
	
	# Unhide (   cause it starts in the middle ):<   ) 
	get_parent().visible = time > 0.04


func return_sine(freq, amp):
	return sin(time * freq) * amp
