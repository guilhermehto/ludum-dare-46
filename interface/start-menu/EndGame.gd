extends Control

onready var rotate : Spatial = $"3DElements/Rotate"

export var rotation_speed : float = 0.25

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://Game.tscn")

func _process(delta):
	rotate.rotate_y(rotation_speed * delta)
