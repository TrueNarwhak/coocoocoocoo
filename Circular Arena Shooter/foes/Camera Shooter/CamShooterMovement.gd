extends Node

const FPS = 60

export(PackedScene) var shot

export var distance_from_point = 260
export var max_speed = 0.2
export var deccel = 0.1
var current_speed = max_speed

export var recoil = 6

onready var point  = get_tree().get_current_scene().get_node("CenterPoint")
onready var player = get_tree().get_current_scene().get_node("Player")
var dir = 1

onready var anim = get_parent().get_node("Sprite/AnimationPlayer")

enum {
	WALK,
	SHOOT
}

var state = WALK

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	get_parent().position.x = point.position.x + (distance_from_point * cos(deg2rad(get_parent().rotation_degrees)))
	get_parent().position.y = point.position.y + (distance_from_point * sin(deg2rad(get_parent().rotation_degrees)))
	
	get_parent().scale.x = lerp(get_parent().scale.x, 1.0, 0.06)
	get_parent().scale.y = lerp(get_parent().scale.y, 1.0, 0.06)
	
	match state:
		WALK:
			
			current_speed = lerp(current_speed, max_speed, deccel)
			get_parent().rotation_degrees += (current_speed * dir) * delta * FPS
			
		SHOOT:
			
			current_speed = lerp(current_speed, 0, deccel)
			get_parent().rotation_degrees += (current_speed * dir) * delta * FPS
	
	# Visual
	get_parent().get_node("Sprite").scale.x = 0.5 * dir


func _on_Flipbox_body_entered(body):
	if body.is_in_group("Player"):
		dir = -dir


func _on_PrepareToShoot_timeout():
	state = SHOOT
	get_parent().get_node("Shoot").start()
	
	# Animation
	anim.play("Prepare")



func _on_Shoot_timeout():
	
	print("Bang!")
#	get_parent().rotation_degrees -= recoil * dir
	get_parent().scale = Vector2(0.75, 1.25)
	
	state = WALK
	
	# Shoot
	var new_shot = shot.instance()
	
	new_shot.global_position = get_parent().get_node("Sprite/ShootPoint").global_position
	new_shot.dir = dir
	new_shot.rotation_degrees = get_parent().rotation_degrees
	
	get_tree().get_current_scene().add_child(new_shot)
	
	# SFX
	get_parent().get_node("ShootSFX").advanced_play()
	
	# Timer
	get_parent().get_node("PrepareToShoot").start()
	



func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Prepare":
		anim.play("Shoot")
	
	if anim_name == "Shoot":
		anim.play("Move")
