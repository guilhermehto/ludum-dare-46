extends Node

onready var woods = $Woods
onready var stones = $Stones

export var weight_limit : int = 20

var capacity : int = weight_limit

func add_item(item) -> void:
	if capacity < item.weight:
		return
	if item is Wood:
		woods.add_child(item)
	
	capacity -= item.weight
