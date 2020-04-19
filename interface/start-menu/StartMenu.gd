extends Control

export var rotation_speed : float = 2.0
export var x_offset : float = 25.0

onready var player_animation_player = $Worldelements/PlayerMesh/Armature/AnimationPlayer
onready var player_mesh : Spatial = $Worldelements/PlayerMesh
onready var tween : Tween = $Tween
onready var menu_options : Control = $MenuOptions
onready var selection_arrow : Sprite = $SelectionArrow

var currently_selected_index : int = 0
var game_scene = "res://Game.tscn"

func _input(event):
	var move_selector : bool = false
	if event.is_action_pressed("ui_down"):
		move_selector = true
		currently_selected_index += 1
		if currently_selected_index == menu_options.get_child_count():
			currently_selected_index = 0
	elif event.is_action_pressed("ui_up"):
		move_selector = true
		currently_selected_index -= 1
		if currently_selected_index < 0:
			currently_selected_index = menu_options.get_child_count() - 1
	elif event.is_action_pressed("ui_accept"):
		match currently_selected_index:
			0:
				get_tree().change_scene(game_scene)
			1:
				get_tree().quit()
	if move_selector == true:
		var new_option : Control = menu_options.get_child(currently_selected_index)
		var new_position = new_option.rect_global_position
		new_position.x -= x_offset
		new_position.y -= new_option.rect_size.y / 2
		
		selection_arrow.position = new_position

func _process(delta: float) -> void:
	player_mesh.rotate_y(rotation_speed * delta)

func _on_AnimationPlayer_animation_finished(anim_name):
	player_animation_player.play(anim_name)
