extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var poo_audio := AudioServer.get_bus_index("Poo")
var non_poo_audio := AudioServer.get_bus_index("Non-Poo")

export(float) var fade_radius := 2.5
export(float) var fade_full := 2.0

func _ready():
	set_process(false)
	
func _on_Area_body_entered(body):
	set_process(true)


func _on_Area_body_exited(body):
	set_process(!get_overlapping_bodies().empty())
	if not is_processing():
		AudioServer.set_bus_volume_db(non_poo_audio, 0.0)


func _process(delta):
	for b in get_overlapping_bodies():
		if b.is_in_group("player"):
			var ppos = b.global_transform.origin
			var mpos = global_transform.origin
			var dist = Vector2(ppos.x, ppos.z).distance_to(Vector2(mpos.x, mpos.z))
			var dfactor = clamp(inverse_lerp(fade_radius, fade_full, dist), 0.0, 1.0)
			AudioServer.set_bus_volume_db(non_poo_audio, lerp(-80.0, 0.0, pow(1.0-dfactor, 0.5)))
