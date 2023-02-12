extends Sprite

# ------------------------------------------------- #

var colors = [
	"c6cecf",
	"d3bfcf",
	"bfd3c9",
	"cad3bf",
	"d3d2bf",
	"d3c3bf",
	"c9a79e",
	"c9bd9e",
	"bfd2c1",
	"bfc6d2",
	"b3d9d6"
]

func _ready():
	randomize()
	new_color()

func _process(delta):
	pass

func new_color():
	modulate = Color(colors[randi() % colors.size()])
