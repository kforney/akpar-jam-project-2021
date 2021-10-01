extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var dialogue_scene: String

export(int) var dlg_max: int = 0

var counter := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	#counter = max(dlg_min, min(counter, dlg_max))
	if (
		event.is_action_pressed("ui_select")
		and not event.is_echo() and dialogue_scene):
			for b in get_overlapping_bodies():
				if b.is_in_group("player"):
					var use_dlg = "%s%s" % [dialogue_scene, (counter + 1) if dlg_max > 0 else ""]
					GameDlg.present(use_dlg)
	
					if dlg_max > 0:
						counter =  wrapi(counter + 1, 0, dlg_max)
					get_tree().set_input_as_handled()
					return
