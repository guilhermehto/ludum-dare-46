extends Spatial
class_name Interactive

onready var interaction_text : Label = $InteractionText

export var action_message : String

const MESSAGE_START = "Press E to"

var player_ref : Player = null

func _ready() -> void:
	interaction_text.text = "%s %s" % [MESSAGE_START, action_message]

func _input(event: InputEvent) -> void:
	if not player_ref:
		return
	
	if event.is_action_pressed("interact"):
		interact(player_ref)

func interact(player: Player) -> void:
	print("Interact function not implemented")

func _can_interact(player) -> bool:
	return true

func _player_exited() -> void:
	pass

func _on_Area_body_entered(body: Node) -> void:
	if body is Player and _can_interact(body):
		interaction_text.show()
		player_ref = body

func _on_Area_body_exited(body: Node) -> void:
	if body is Player:
		interaction_text.hide()
		player_ref = null
		_player_exited()
