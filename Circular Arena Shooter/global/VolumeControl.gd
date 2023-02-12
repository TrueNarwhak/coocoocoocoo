extends CanvasLayer


var volume_sets = [
	-80.0,
	-8.8,
	-1.3,
	0.0,
	1.3,
	2.0
]

# ------------------------------------------------- #

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("vol_up"):
		$AnimatedSprite.frame += 1
		$AnimationPlayer.play("KnockVolume")
	
	if Input.is_action_just_pressed("vol_down"):
		$AnimatedSprite.frame -= 1
		$AnimationPlayer.play("KnockVolume")
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("PreMaster"), volume_sets[$AnimatedSprite.frame])
