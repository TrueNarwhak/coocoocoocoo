extends Area2D

export var distance_from_point = 260
onready var point = get_tree().get_current_scene().get_node("FacePlayerPoint")

signal collected

# ------------------------------------------------- #

func _ready():
	randomize()
	rotation_degrees = get_tree().get_current_scene().get_node("FacePlayerPoint").rotation_degrees + rand_range(120.0, 240)
	
	position.x = point.position.x + (distance_from_point * cos(deg2rad(rotation_degrees)));
	position.y = point.position.y + (distance_from_point * sin(deg2rad(rotation_degrees)));
	
	connect("collected", get_tree().get_current_scene(), "_on_collected")

func _process(delta):
	look_at(get_tree().get_current_scene().get_node("FacePlayerPoint").position)
	
	# Color
	if get_tree().get_current_scene().get_node("Foes").get_child_count() == 0:
		$Sprite.frame = 0
		modulate.a = 1.0
	elif get_tree().get_current_scene().get_node("Foes").get_child_count() > 0:
		$Sprite.frame = 1
		modulate.a = 0.8


func _on_GoalPoint_body_entered(body):
	if body.is_in_group("Player"):
		if get_tree().get_current_scene().get_node("Foes").get_child_count() == 0:
			emit_signal("collected")
			call_deferred("queue_free")
			
