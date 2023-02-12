# CONTROLLER BY EVE AKA TRUE NARWHAK
extends KinematicBody2D
class_name Platformer

const FPS = 60

export var max_speed       = 850   # Maximum Speed of the Player Character
export var accel           = 24    # Time taken to get to max speed
export var deccel          = 0.2   # Time taken to return to zero speed
export var climb           = 20    # Jumping gravity
export var fall            = 34    # Falling Gravity
export var max_fall_speed  = 30    # Maximum fall Speed, how many times the fall value can the player go
export var jump_height     = 800   # Height of jump
export var variable_jump   = 2     # How variable the jump is
export var air_resistance  = 0.2   # Speed Resistance while in air
export var skid_boost      = 3     # Multiplier for skidding (turn to zero to turn it off)
export var apex_threshold  = 90    # Ammout for apex boost (this ones really hard to calculate just by numbers, so try printing motion.y every frame)
export var apex_boost      = 2     # Multiplier for motion on apex
export var fast_fall       = 150   # Added fall speed during fall
export var ffall_threshold = 20    # how much of jump need to be completed before fast fall

onready var sprite_holder = $Sprites
onready var sprite = $Sprites/Main
onready var eye_sprite = $Sprites/Main/Eye
onready var wheel_sprite = $Sprites/Wheel
onready var cyotte_time = $CoyoteTime
onready var jump_buffer = $JumpBuffer
onready var hitbox = $Hitbox
onready var unblink = $Sprites/Unblink

onready var weapon_holder = $Sprites/WeaponHolder
onready var weapon_holder_sprite = $Sprites/WeaponHolder/Sprite
onready var weapon_holder_point = $Sprites/WeaponHolder/Position

export(PackedScene) var particles

var motion = Vector2(0,0)
var snap
var x_input

export var max_hp = 8
var hp = max_hp

signal update_health_dispaly

# ------------------------------------------------- #

func _ready():
	hitbox.connect("take_damage", self, "_on_take_damage")

func _physics_process(delta):
	x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	# Move right
	if x_input != 0:
		
		motion.x += x_input * accel * delta * FPS
		motion.x = clamp(motion.x, -max_speed, max_speed)
		
		sprite.flip_h = x_input < 0
	
	# Gravity
	if motion.y < 0:
		motion.y += climb * delta * FPS
	if motion.y >= 0:
		motion.y += fall * delta * FPS
		motion.y = clamp(motion.y, -fall, (fall * max_fall_speed))

		# Cyote Time
		if cyotte_time.is_stopped() and is_on_floor():
			cyotte_time.start()
	
	# Jump
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start()
		
	if is_on_floor() or cyotte_time.time_left > 0:
		if !jump_buffer.is_stopped():
			motion.y = -jump_height
			
			cyotte_time.stop()
			jump_buffer.stop()
	
	if is_on_floor():
		
		# Drag
		if x_input == 0:
			motion.x = lerp(motion.x, 0, deccel)
		
		# Skid
		if (x_input < 0 and motion.x > 0) or (x_input > 0 and motion.x < 0):
			motion.x += x_input * accel * skid_boost * delta * FPS
		
		# Rotate
		rotation = get_floor_normal().angle() + PI/2
		
	else:
#		if Input.is_action_pressed("dash"):
#			motion.x = 500
#			motion.y = 0
		
		# Varible Jump height
		if Input.is_action_just_released("jump") and motion.y < -jump_height/variable_jump:
			motion.y = -jump_height/variable_jump
		
		# Air Drag
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_resistance)
		
		# Apex Boost
		if motion.y >= -apex_threshold and motion.y < apex_threshold:
			motion.x += apex_boost * x_input
		
		# Keep direction in air
		rotation_degrees = get_tree().get_current_scene().get_node("FacePlayerPoint").rotation_degrees - 90
		
	
	# Fast Fall
	if Input.is_action_pressed("down") and !is_on_floor() and motion.y >= 0:
		motion.y += fast_fall * delta * FPS
	
	# Snap
	snap = Vector2.DOWN * 128 if !is_on_floor() else Vector2.ZERO
	
	# Apply
	motion = move_and_slide_with_snap(motion.rotated(rotation), snap, -transform.y, true, 4, PI/3)
	motion = motion.rotated(-rotation)
	
	# Health
	if hp <= 0:
		die()
	
	# Weapon Holder
	if sprite.flip_h:
		weapon_holder.scale.x = -1
	else:
		weapon_holder.scale.x = 1

func die():
	GameOverScreen.display()
	visible = false
	
	# Proccess
	set_physics_process(false)
	set_process(false)
	
	# Particles
	var new_particles = particles.instance()
	
	new_particles.global_position = global_position
	get_tree().get_current_scene().call_deferred("add_child", new_particles)
	
	# Hitbox
	$Hitbox/CollisionShape2D.disabled = true
	
#	get_tree().change_scene("res://level/KeyBypass.tscn")

func _on_take_damage(attack):
	print("ouchie!!!!!")
	
	# Destroy
	if attack.is_in_group("Attack"):
		attack.call_deferred("queue_free")
	
	
	sprite_holder.scale = Vector2(1.5, 0.75)
	
	# Knockback
	motion.x = 0
	motion.x = 200 * weapon_holder.scale.x
	
	# HP
	hp -= 1
	hp = clamp(hp, 0, 99999)
	
	print(hp)
#	get_tree().get_current_scene().get_node("ClockHealthDisplay").damage()
	emit_signal("update_health_dispaly", hp)
	
	
	sprite_holder.material.set_shader_param("flash_mod", 1.0)
	$FlashTimer.start()
	
	#SFX
	if visible:
		$DamageSFX.advanced_play()


func _on_FlashTimer_timeout():
	sprite_holder.material.set_shader_param("flash_mod", 0.0)
