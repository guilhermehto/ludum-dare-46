extends Node

onready var gui : Control = $GameWorld/GUI
onready var player : Player = $GameWorld/Player
onready var game_world : Spatial = $GameWorld

onready var transition_rect : ColorRect = $TransitionRect
onready var tween : Tween = $Tween

var game_end_iu := "res://interface/start-menu/EndGame.tscn"
var passed_days : int = 0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		_on_game_ended('cu')

func _ready() -> void:
	gui.initialize(player)
	GlobalSignals.connect("game_ended", self, "_on_game_ended")
	GlobalSignals.connect("day_passed", self, "_on_day_passed")

func _on_day_passed(passed) -> void:
	passed_days = passed

func _on_game_ended(reason) -> void:
	GlobalSignals.emit_notified(reason)
	
	tween.interpolate_property(transition_rect, 
	"color", 
	transition_rect.color, 
	Color(0,0,0,1), 
	3.0, 
	Tween.TRANS_QUINT, 
	Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	transition_rect.color = Color(0,0,0,0)
	var end_game_ui = load(game_end_iu).instance()
	end_game_ui.initialize(passed_days)
	add_child(end_game_ui)
	remove_child(game_world)
