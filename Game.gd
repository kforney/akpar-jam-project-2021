extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const dlg_scn := preload("res://addons/dialogic/Dialog.tscn")
onready var dlg_holder := $DialogPlaceholder

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var present_lock := false setget _set_present_lock

func _set_present_lock(v):
	present_lock = v
	if is_inside_tree():
		get_tree().call_group("lockable", "update_lock", v)

var active_scn := ""

func present_dlg(dlg):
	if Dialogic.get_current_timeline():
		return
	if present_lock: return

	print("presenting %s" % dlg)
	self.present_lock = true
	var dlg_node = Dialogic.start(dlg)
	add_child(dlg_node)
	dlg_node.connect("timeline_end", self, "_on_timeline_end")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_timeline_end(timeline_name):
	print("timeline end %s" % timeline_name)
	get_tree().call_group("early_unlockable", "early_unlock")
	yield(get_tree().create_timer(0.5), "timeout")
	self.present_lock = false
	print("present_unlocked")
