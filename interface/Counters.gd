extends VBoxContainer

onready var days_label : Label = $Days/Label

func update_days(days) -> void:
	days_label.text = "Survived: %s days" % days
