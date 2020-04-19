extends Node

onready var gui : Control = $GUI
onready var player : Player = $Player

func _ready() -> void:
	gui.initialize(player)
