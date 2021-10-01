extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var dialogue_scene: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if (
		event.is_action_pressed("ui_select")
		and not event.is_echo() and dialogue_scene):
			for b in get_overlapping_bodies():
				if b.is_in_group("player"):
					GameDlg.present(dialogue_scene)
					get_tree().set_input_as_handled()
					return
	
