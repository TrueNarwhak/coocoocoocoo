extends Node2D

var foe_list = [
	preload("res://foes/Train/FoeTrain.tscn"),
	preload("res://foes/Fish/FoeFish.tscn"),
	preload("res://foes/Slammer/FoeSlammer.tscn"),
	preload("res://foes/Camera Shooter/FoeCameraShooter.tscn")
]

var to_spawn_orb = preload("res://obj/ToSpawnOrb.tscn")

onready var spawnpoint_list = [
	$SpawnPoint,
	$SpawnPoint2,
	$SpawnPoint3,
	$SpawnPoint4,
	$SpawnPoint5,
	$SpawnPoint6,
	$SpawnPoint7,
	$SpawnPoint8,
]

var dist = 260

# ------------------------------------------------- #

func _ready():
	randomize()

func _process(delta):
	pass

func spawn(ammount):
	var i = 0
	for child in get_children():
		if i < ammount:
			i += 1
			
			spawnpoint_list[i].rotation_degrees = floor(rand_range(0, 360))
			
#			var new_foe = foe_list[randi() % foe_list.size()].instance()
#			new_foe.position = spawnpoint_list[i].global_position
#			new_foe.position += Vector2(dist, 0).rotated(spawnpoint_list[i].rotation)
			
			var new_orb = to_spawn_orb.instance()
			new_orb.spawned_from = spawnpoint_list[i]
			new_orb.to_spawn = foe_list[randi() % foe_list.size()]
			
			new_orb.rotation_degrees = spawnpoint_list[i].rotation_degrees
			new_orb.position = spawnpoint_list[i].global_position
			new_orb.position += Vector2(dist, 0).rotated(spawnpoint_list[i].rotation)
			
			get_tree().get_current_scene().get_node("Foes").call_deferred("add_child", new_orb)
			
#			print(Vector2(dist, 0).rotated(spawnpoint_list[i].rotation))
#			print(spawnpoint_list[i].rotation_degrees)
