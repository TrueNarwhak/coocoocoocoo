extends AudioStreamPlayer
class_name RandomAudioStreamPlayer

export(Array, AudioStream) var soundlist 
var rand_index:int

# ------------------------------------------------- #

func _ready():
	randomize()
	rand_index = randi() % soundlist.size()

func advanced_play():
	stream = soundlist[rand_index]
	rand_index = randi() % soundlist.size()
	play()
