extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const dlg_scn := preload("res://addons/dialogic/Dialog.tscn")
onready var dlg_holder := $DialogPlaceholder

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var present_lock := false

var active_scn := ""

func present_dlg(dlg):
	if present_lock: return

	print("presenting %s" % dlg)
	present_lock = true
	var dlg_node = Dialogic.start(dlg)
	add_child(dlg_node)
	dlg_node.connect("timeline_end", self, "_on_timeline_end")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timeline_end(timeline_name):
	present_lock = false
	print("timeline end %s" % timeline_name)


func _on_timeline_start(timeline_name):
	present_lock = true
