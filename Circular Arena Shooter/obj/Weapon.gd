extends Node

export(Resource) var weapon_slot_1 
#export(Resource) var weapon_slot_2 
export var recoil = 440
export var rotation_recoil = 30

onready var cooldown_timer = $CoolDown

var can_shoot = true

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_shoot and get_parent().visible:
		shoot()
 
func shoot():
	
	Stats.bullets_shot += 1
	can_shoot = false
	
	# Timer
	cooldown_timer.wait_time = weapon_slot_1.cooldown
	cooldown_timer.start()
	
	# Shot
	var new_shot = weapon_slot_1.shot.instance()
	new_shot.position = get_parent().weapon_holder_point.global_position
	new_shot.scale.y = get_parent().weapon_holder.scale.x
	
	if get_parent().sprite.flip_h:
		new_shot.dir = 1
	else:
		new_shot.dir = -1
	
	get_parent().get_parent().add_child(new_shot)
	
	# Blink
	get_parent().eye_sprite.frame = 0
	get_parent().unblink.start()
	
	# Recoil
	get_parent().sprite_holder.rotation_degrees = rotation_recoil * -get_parent().weapon_holder.scale.x
	
	if get_parent().is_on_floor():
		get_parent().motion.x = recoil * -get_parent().weapon_holder.scale.x
	
	# SFX 
	$ShootSFX.advanced_play()

func _on_CoolDown_timeout():
	can_shoot = true
