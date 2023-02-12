extends Node2D

export var reshape_speed = 0.04
onready var squashcast = $SquashCast
var can_squish_ground = true

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	
	scale.x = lerp(scale.x, 1.0, reshape_speed)
	scale.y = lerp(scale.y, 1.0, reshape_speed)
	rotation_degrees = lerp(rotation_degrees, 0, reshape_speed)
	
	if squashcast.is_colliding() and squashcast.get_collider().is_in_group("Ground") and Input.is_action_just_pressed("jump"):
		scale = Vector2(0.75, 1.7)
		can_squish_ground = true
	
	if Input.is_action_pressed("down") and squashcast.is_colliding() and squashcast.get_collider().is_in_group("Ground") and !can_squish_ground:
		scale = Vector2(1.7, 0.75)
		
		get_parent().motion = Vector2.ZERO 
		get_parent().get_node("Weapon").set_process(false)
	else:
		get_parent().get_node("Weapon").set_process(true)

func _on_LandingArea_body_entered(body):
	if body.is_in_group("Ground"):
		scale = Vector2(1.7, 0.75)
		can_squish_ground = false
		
		# SFX
		$LandSFX.advanced_play()


func _on_Unblink_timeout():
	$Main/Eye.frame = 0
