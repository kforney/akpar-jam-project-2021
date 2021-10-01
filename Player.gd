extends KinematicBody

onready var ray := $LookAt/RayCast
onready var cam := $Camera
onready var look_at := $LookAt

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var teleport_dist := 5.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	ray.force_raycast_update()
	if ray.get_collider():
		var dist: float = ray.get_collision_point().distance_to(look_at.global_transform.origin)
		var target: Vector3 = (ray.get_collision_point()-look_at.global_transform.origin).normalized() * max(1.0, dist - 0.5)
		if cam.global_transform.origin.distance_to(target) > teleport_dist:
			cam.global_transform.origin = target
		else:
			cam.global_transform.origin = cam.global_transform.origin.linear_interpolate(target, 0.3)
		cam.look_at(target, Vector3.UP)
	
	rotation_degrees.y += Input.get_axis("game_left", "game_right") * delta * 540.0
