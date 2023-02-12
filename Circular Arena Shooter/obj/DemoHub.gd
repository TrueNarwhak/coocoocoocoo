extends Control

onready var icons = [$HBoxContainer/ColorBox, $HBoxContainer/ColorBox2, $HBoxContainer/ColorBox3, $HBoxContainer/ColorBox4, $HBoxContainer/ColorBox5]
var taken = 0

# ------------------------------------------------- #

func _ready():
	set_as_toplevel(true)

func _process(delta):
	$Label.text = "Cleared: " + str(Stats.cleared)
 
func remove_health():
	icons[taken].hide()
	taken += 1
	
