extends KinematicBody

signal died

onready var warm_body = $WarmBody
onready var animation_player = $AnimationPlayer

export var max_hp : int = 25

var hp : int = max_hp

func _ready():
	randomize()
	animation_player.playback_speed = rand_range(0.75, 1.25)

func damage(value: int) -> void:
	hp = max(0, hp - value)
	if hp == 0:
		emit_signal("died")
		queue_free()

func _on_WarmBody_cold_damaged(damage) -> void:
	damage(damage)
	
