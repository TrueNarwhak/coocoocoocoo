extends Node

const FPS = 60

onready var p = get_parent()
onready var player = get_tree().get_current_scene().get_node("Player")
onready var point = get_tree().get_current_scene().get_node("CenterPoint")

export var grav = 3
export var x_jump = 120
export var y_jump = 200

var motion = Vector2.ZERO
var snap

# ------------------------------------------------- #

func _ready():
	print(p.cant_be_hit)
	$JumpTimer.connect("timeout", self, "_on_jump_timer_timeout")
	snap = Vector2.DOWN * 128

func _physics_process(delta):
	
	# Invinciblity
	p.cant_be_hit = p.is_on_floor()
	
	# Snap
	snap = Vector2.DOWN * 128 if !p.is_on_floor() else Vector2.ZERO
	
	
	if p.is_on_floor():
		p.rotation = p.get_floor_normal().angle() + PI/2
		p.get_node("CheckStand").enabled = true
		
		p.get_node("Sprite").modulate.a = 0.7
	else:
		# Grav
		motion.y += grav * delta * FPS
		p.get_node("Sprite").modulate.a = 1.0
		p.look_at(point.global_position)
		p.rotation_degrees += 90
		
	
	# Collider
	if p.get_node("CheckStand").is_colliding() and p.get_node("CheckStand").get_collider():
		motion = Vector2.ZERO
	
	# Apply
	motion = p.move_and_slide_with_snap(motion.rotated(p.rotation), snap, -p.transform.y, true, 40, PI/3)
	motion = motion.rotated(-p.rotation)

func _on_jump_timer_timeout():
	if p.is_on_floor():
		p.get_node("CheckStand").enabled = false
		
		motion.x = -x_jump
		motion.y = -y_jump
