extends Interactive

var crafting_table : Spatial

func _ready() -> void:
	crafting_table = get_parent()

func interact(player: Player) -> void:
	crafting_table.player_ref = player
	crafting_table.open_ui()

func _player_exited() -> void:
	crafting_table.close_ui()
