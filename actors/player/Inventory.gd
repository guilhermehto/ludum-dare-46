extends Node

onready var woods = $Woods
onready var stones = $Stones

export var weight_limit : int = 20

var capacity : int = weight_limit

func add_item(item) -> void:
	if capacity < item.weight:
		return
	
	capacity -= item.weight
	
	if item is Wood:
		woods.add_child(item)
		GlobalSignals.emit_inventory_updated({
			"item": item, 
			"carrying_weight": weight_limit - capacity, 
			"weight_limit": weight_limit, 
			"carrying": woods.get_child_count()
		})

func remove_wood() -> Wood:
	if woods.get_child_count() == 0:
		return null
	var removed_wood = woods.get_children()[0]
	woods.remove_child(removed_wood)
	
	capacity += removed_wood.weight
	
	GlobalSignals.emit_inventory_updated({
			"item": removed_wood, 
			"carrying_weight": weight_limit - capacity, 
			"weight_limit": weight_limit, 
			"carrying": woods.get_child_count()
		})
	
	return removed_wood
