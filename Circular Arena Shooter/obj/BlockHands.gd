extends Node2D

const FPS = 60
export var tick_speed = 4 # INITIALLLL :) will be chamn
export var minimum_tick_time  = 0.1
export var decrease_tick_time = 0.2

onready var block_hands = [
	$BlockHand,
	$BlockHand3,
	$BlockHand2,
	$BlockHand4,
]

var block_points = 0
var sfx_tracker = 0

# ------------------------------------------------- #

func _ready():
	get_parent().connect("cleared_point_given", self, "_on_cleared_point_given")

func _process(delta):
	block_points = clamp(block_points, -1, 4)
 
func _on_cleared_point_given():
	# Add hands
	if Stats.cleared%3 == 0 and block_points < 4: # could also add block points to the %3 to make it more infrequent
		print("yeah this enough")
		
		block_hands[block_points].visible = true
		block_hands[block_points].call_deferred("shape_state", false)
		
		block_points += 1
		block_points = clamp(block_points, -1, 4)
		
		sfx_tracker = 1
	
	# Timer
	if $TickTimer.wait_time > minimum_tick_time:
		$TickTimer.wait_time -= decrease_tick_time
		print($TickTimer.wait_time) 



func _on_TickTimer_timeout():
	rotation_degrees += tick_speed
	
	if sfx_tracker != 0:
		$TickSFX.advanced_play()
