extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func present(dlg):
	var g := get_tree().get_nodes_in_group("game")
	if g.size() != 1:
		push_error("BAD THINGS")
	else:
		g[0].present_dlg(dlg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
