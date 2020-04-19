extends VBoxContainer

onready var temp_texture_progress : TextureProgress = $Temperature/TextureProgress

var player_ref : Player = null

func _process(delta: float) -> void:
	if not player_ref:
		return
	var warm_body : WarmBody = player_ref.warm_body as WarmBody
	var player_temp_percentage = 1 - (warm_body.max_body_temperature - warm_body.temperature) / (warm_body.max_body_temperature - warm_body.minimun_body_temperature)
	temp_texture_progress.value = 100 * player_temp_percentage

func initialize(player: Player) -> void:
	player_ref = player
