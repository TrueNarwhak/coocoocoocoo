extends Area2D

export var player_hitbox = false
signal take_damage

# ------------------------------------------------- #

func _ready():
	connect("area_entered", self, "_on_area_entered")
	connect("body_entered", self, "_on_body_entered")

func _process(delta):
	pass

func _on_area_entered(area):
	if area.is_in_group("Attack"):
		emit_signal("take_damage", area)

	if player_hitbox and !area.is_in_group("FoeAreaException") and area.get_parent().is_in_group("Foe"):
		emit_signal("take_damage", area)

func _on_body_entered(body):
	pass
