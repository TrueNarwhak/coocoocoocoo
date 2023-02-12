extends Node

onready var p = get_parent()
onready var point = get_tree().get_current_scene().get_node("CenterPoint")

enum {
	SLAM,
	RISE,
}

var state = RISE

export var slam_speed = 450
export var rise_speed = 100

export var max_dist = 60.0
var current_dist = 260

# trying to figure this shit out programming makes me want to die\
# OMFG IT WAS A TYPO
# this will remain as a mounument of my rage
var inhereted_rotation_degrees = 0
var i_want_to_die
var locked_pos

# ------------------------------------------------- #

func _ready():
#	# TEMP
	
#	p.get_node("FaceNodes").look_at(point.global_position)
#	p.get_node("FaceNodes").rotation_degrees += 90
#
#	p.position.x = point.position.x + (current_dist)
#	p.position.y = point.position.y + (current_dist)
	
#	p.look_at(point.position)
	pass

func _physics_process(delta):
	
	p.get_node("FaceNodes").look_at(point.global_position)
	p.get_node("FaceNodes").rotation_degrees += 90
	
	get_parent().position.x = point.position.x + (current_dist * cos(deg2rad(get_parent().rotation_degrees)))
	get_parent().position.y = point.position.y + (current_dist * sin(deg2rad(get_parent().rotation_degrees)))
	
	p.rotation_degrees += 0
	
	p.cant_be_hit = state == RISE
#	p.cant_be_hit = current_dist == max_dist
	
	
	match state:
		RISE:
			current_dist -= rise_speed * delta
			current_dist = clamp(current_dist, max_dist, 100000)
			
			p.modulate.a = 0.5
		
		SLAM:
			if !p.get_node("FaceNodes/SlamCast").is_colliding():
				current_dist += slam_speed * delta
			
			p.modulate.a = 1
			
	
	p.get_node("FaceNodes/Sprite").scale.x = lerp(p.get_node("FaceNodes/Sprite").scale.x, 0.4, p.reshape_speed)
	p.get_node("FaceNodes/Sprite").scale.y = lerp(p.get_node("FaceNodes/Sprite").scale.y, 0.4, p.reshape_speed)
	
	
	# Particles
#	p.get_node("FaceNodes/Rings").visible = state == RISE
	p.get_node("FaceNodes/Rings").emitting = state == RISE
	
	p.get_node("FaceNodes/Rings").modulate.a = lerp(p.get_node("FaceNodes/Rings").modulate.a, 1.0 * int(state == RISE), 0.04)

func slam():
	state = SLAM
	p.get_node("Rise").start()

func _on_ActivationArea_body_entered(body):
	if body.is_in_group("Player"):
		p.get_node("AnimationPlayer").play("Shake")


func _on_AnimationPlayer_animation_finished(anim_name):
	slam()


func _on_Rise_timeout():
	state = RISE


