extends Interactive

func interact(player: Player) -> void:
	var bonfire = get_parent()
	var wood = player.inventory.remove_wood()
	if wood == null:
		GlobalSignals.emit_signal("notified", "You're out of wood")
	var wood_added = bonfire.add_wood(wood)
	if not wood_added:
		player.inventory.add_item(wood)
		GlobalSignals.emit_signal("notified", "Bonfire is full of wood")
	
func _can_interact(player) -> bool:
	return player.inventory.woods.get_child_count() > 0
