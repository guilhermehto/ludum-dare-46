extends KinematicBody
class_name Player

export var move_speed := 15.0

onready var inventory = $Inventory

func _physics_process(_delta: float) -> void:
	var horizontal_movement := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var vertical_movement := int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	var movement_vector = Vector3(horizontal_movement, 0, vertical_movement).normalized()

	move_and_slide(movement_vector * move_speed, Vector3.UP)
	look_at(get_mouse_position(), Vector3.UP)

func get_mouse_position() -> Vector3:
	var camera = get_viewport().get_camera()
	var depth = global_transform.origin.distance_to(camera.global_transform.origin)
	var mouse_position = camera.project_position(get_viewport().get_mouse_position(), depth)
	mouse_position.y = translation.y
	return mouse_position
