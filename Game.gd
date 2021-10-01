extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var present_lock := false

var active_scn := ""

func present_dlg(dlg):
	if present_lock: return
	var scn = Dialogic.start(dlg)
	active_scn = dlg
	add_child(scn)
	present_lock = true
	scn.connect("timeline_end", self, "_on_timeline_end")

func _on_timeline_end(scn):
	if active_scn and scn == active_scn:
		present_lock = false
		active_scn = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
