extends KinematicBody2D
class_name Foe

export var max_hp:int
export var hit_squish = Vector2(1.0, 1.0)
export var reshape_speed = 0.06

onready var hp = max_hp

var cant_be_hit = false

onready var hitbox = $Hitbox
onready var movement = $Movement
onready var unflash = $Unflash

onready var particles = preload("res://obj/DeathParticles.tscn")

# ------------------------------------------------- #

func _ready():
	add_to_group("Foe")
	
	hitbox.connect("take_damage", self, "_on_take_damage")
	unflash.connect("timeout", self, "_on_unflash_timeout")
	

func _process(delta):
	
	# Visual
	scale.x = lerp(scale.x, 1, reshape_speed)
	scale.y = lerp(scale.y, 1, reshape_speed)

func die():
	print("dead")

func _on_take_damage(attack):
	if !cant_be_hit and attack.player_shot:
		
		# Destroy
		if attack.is_in_group("Attack"):
			attack.call_deferred("queue_free")
		
		scale = hit_squish
		
		# HP
		hp -= 1
		
		if hp == 0:
			call_deferred("queue_free")
		
		# Shader
		material.set_shader_param("flash_mod", 1.0)
		unflash.start()
		
		# SFX
		$HitSFX.advanced_play()

func _exit_tree():
	var new_particles = particles.instance()
	
	new_particles.global_position = global_position
	get_tree().get_current_scene().call_deferred("add_child", new_particles)

func _on_unflash_timeout():
	material.set_shader_param("flash_mod", 0.0)



