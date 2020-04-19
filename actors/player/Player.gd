extends KinematicBody
class_name Player

export var move_speed := 15.0

onready var inventory = $Inventory
onready var warm_body = $WarmBody
onready var hands = $"PlayerMesh/Armature/handrBoneAttachment/HandPosition/Hands"
onready var animation_player = $PlayerMesh/Armature/AnimationPlayer

func _physics_process(_delta: float) -> void:
	if animation_player.current_animation == "Hit":
		return
	
	var horizontal_movement := int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	var vertical_movement := int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	var movement_vector = Vector3(horizontal_movement, 0, vertical_movement).normalized()

	move_and_slide(movement_vector * move_speed, Vector3.UP)
	
	if movement_vector != Vector3.ZERO:
		if animation_player.current_animation != "Run":
			animation_player.play("Run")
		look_at(global_transform.origin + movement_vector * 3, Vector3.UP)
	else:
		if animation_player.current_animation != "Idle":
			animation_player.play("Idle")
		

func get_mouse_position() -> Vector3:
	var camera = get_viewport().get_camera()
	var depth = global_transform.origin.distance_to(camera.global_transform.origin)
	var mouse_position = camera.project_position(get_viewport().get_mouse_position(), depth)
	mouse_position.y = translation.y
	return mouse_position

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	print(animation_player.current_animation)
#	if anim_name != "Hit":
#		animation_player.play(anim_name)

func _on_axe_hit() -> void:
	animation_player.play("Hit")
