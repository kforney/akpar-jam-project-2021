extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var teleport_dist := 5.0

export(float) var turn_speed := 360.0
export(float) var walk_speed := 10.0

onready var camera_base := $CameraBase
onready var remote_transform := $CameraBase/CameraOffset/RemoteTransform

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):	
	var inp_x := Input.get_axis("game_left", "game_right")  # * delta * turn_speed
	var inp_y := Input.get_axis("game_up", "game_down")
	var grav := 0.98
	var move_vec := walk_speed * Vector3(inp_x, 0.0, inp_y)
	move_and_slide(move_vec, Vector3.UP)
	remote_transform.look_at(camera_base.global_transform.origin, Vector3.UP)
