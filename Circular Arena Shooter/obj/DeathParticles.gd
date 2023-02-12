extends Particles2D

# ------------------------------------------------- #

func _ready():
	emitting = true
	$AnimationPlayer.play("Explosion")
	
	#SFX
	$BoomSFX.advanced_play()

func _process(delta):
	pass




func _on_AnimationPlayer_animation_finished(anim_name):
	call_deferred("queue_free")
