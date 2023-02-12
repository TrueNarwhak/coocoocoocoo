extends KinematicBody2D

export var speed = 14
export(PackedScene) var exposion

var motion = Vector2(0,0)

# ------------------------------------------------- #

func _ready():
	pass

func _physics_process(delta):
	motion = Vector2(1, 0).rotated(rotation) * (speed * 1000) * delta
	motion = move_and_slide(motion)
	
	if $RayCast2D.is_colliding() and $RayCast2D.get_collider().is_in_group("Ground") and $ExplodeTimer.is_stopped():
		$ExplodeTimer.start()

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body._on_take_damage()
		print("Player touched bomb")


func _on_ExplodeTimer_timeout():
	var new_explosion = exposion.instance()
	new_explosion.player_shot = false
	new_explosion.position = position
	new_explosion.rotation_degrees = rotation_degrees
	
	get_tree().get_current_scene().add_child(new_explosion)
	
	call_deferred("queue_free")
