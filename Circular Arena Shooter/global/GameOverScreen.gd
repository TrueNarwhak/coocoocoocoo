extends CanvasLayer

var can_restart
signal appear

# ------------------------------------------------- #

func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("shoot") and can_restart:
		$AnimationPlayer.play("RESET")
		can_restart = false
		visible = false
		
		Stats.reset_stats()
		get_tree().change_scene("res://level/HoldingRoom.tscn")
 
func display():
	emit_signal("appear")
	
	visible = true
	
	# Stat shit
	Stats.stopped = true
	
	# Text 
	$Stats/Cleared/ClearedLabel.text = "Cleared: " + str(Stats.cleared)
	$Stats/Bullets/BulletsLabel.text = "Bullets: " + str(Stats.bullets_shot)
	$Stats/Time/TimeLabel.text    = "Time: " + str(stepify(Stats.time, 0.01))
	
	$AnimationPlayer.play("Display")


func midway():
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Display":
		can_restart = true
