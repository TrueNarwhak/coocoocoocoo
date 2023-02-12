extends AudioStreamPlayer

var appear_stop = false
onready var loop = preload("res://sounds/!music/final/Clock_song-loop.mp3")

# ------------------------------------------------- #

func _ready():
	GameOverScreen.connect("appear", self, "_on_appear")

func _process(delta):
	pass
 
func _on_appear():
	stop()
	appear_stop = true


func _on_Music_finished():
	if !appear_stop:
		set_stream(loop)
		play()
	
