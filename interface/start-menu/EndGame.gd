extends Control

onready var rotate : Spatial = $"3DElements/Rotate"
onready var title : Label = $VBoxContainer/Title

export var rotation_speed : float = 0.25

var survived_days : int = 0

func initialize(days: int) -> void:
	survived_days = days

func _ready():
	title.text = "you survived\n%s\ndays" % survived_days

func _input(event):
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene("res://interface/start-menu/StartMenu.tscn")

func _process(delta):
	rotate.rotate_y(rotation_speed * delta)
