extends Node2D

export var tick_speed = 0.06
export var small_tick_speed = 5

onready var goalpoint = preload("res://obj/GoalPoint.tscn")
onready var big_hand = $ClockHands/BigHand
onready var small_hand = $ClockHands/SmallHand
onready var color_bg = $StaticElements/ColorBG
onready var spawners = $Spawners
onready var collect_sfx = $CollectSFX

var target_degrees = 0

signal cleared_point_given

# ------------------------------------------------- #

func _ready():
	randomize()

func _process(delta):
	big_hand.rotation_degrees = lerp(big_hand.rotation_degrees, target_degrees, tick_speed)
	small_hand.rotation_degrees += small_tick_speed * delta

func _on_collected():
	print("lmao no way")
	Stats.cleared += 1
	emit_signal("cleared_point_given")
	
	# Sound
	collect_sfx.advanced_play()
	
	# New goal point
	var this_goalpoint = goalpoint.instance()
	call_deferred("add_child", this_goalpoint)
	
	# New BG color
	color_bg.new_color()
	
	# Hand Tick
	target_degrees -= 22.5
	
	# Spawn
	spawners.spawn(randi() % 2 + 2)
