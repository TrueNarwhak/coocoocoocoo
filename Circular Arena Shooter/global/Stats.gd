extends Node

var cleared = 0
var bullets_shot = 0
var time = 0

var stopped

# ------------------------------------------------- #

func _process(delta):
	if !stopped:
		time += delta

func reset_stats():
	cleared = 0
	bullets_shot = 0
	time = 0
	
	stopped = false
