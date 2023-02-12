extends Node2D

var to_spawn:PackedScene
var spawned_from
var dist = 260

# ------------------------------------------------- #

func _ready():
	$AnimationPlayer.play("Spawn")

func _process(delta):
#	print("orb: " + str(rotation_degrees))
	pass
 

func _on_AnimationPlayer_animation_finished(anim_name):
	
	var new_spawn = to_spawn.instance()
	
	new_spawn.position = global_position
	new_spawn.rotation_degrees = rotation_degrees
	
	get_tree().get_current_scene().get_node("Foes").call_deferred("add_child", new_spawn)
	call_deferred("queue_free")
	
	print(spawned_from)
	pass
