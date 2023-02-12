extends Area2D
class_name Shot

const FPS = 60

export var speed = 2.0

onready var point = get_parent().get_node("CenterPoint")

export var player_shot = true

var distance_from_point:float
var dir = 1

# ------------------------------------------------- #

func _ready():
	add_to_group("Attack")
	add_to_group("Shot")
	
	distance_from_point = sqrt(pow((position.x - point.position.x), 2) + pow((position.y - point.position.y),2))
	
	if player_shot:
		rotation_degrees = get_parent().get_node("FacePlayerPoint").rotation_degrees


func _process(delta):
	
	position.x = point.position.x + (distance_from_point * cos(deg2rad(rotation_degrees)))
	position.y = point.position.y + (distance_from_point * sin(deg2rad(rotation_degrees)))
	
	rotation_degrees += (speed * dir) * delta * FPS
