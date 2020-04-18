extends Spatial

onready var timer : Timer = $Timer
onready var mesh_instace : MeshInstance = $MeshInstance

export var time_to_regrow_stage : float = 120.0
export var stage_meshes = []
export var initial_hp : float = 50.0

var growth_stage = 3
var current_hp = initial_hp

func _ready() -> void:
	timer.wait_time = time_to_regrow_stage

func _fall() -> void:
	# drop stuff
	growth_stage = 1
	timer.start()
	mesh_instace.mesh = stage_meshes[0]

func _on_Timer_timeout() -> void:
	growth_stage += 1
	mesh_instace.mesh = stage_meshes[growth_stage - 1]
	
	if growth_stage < 3:
		timer.start()
	else:
		current_hp = initial_hp

func hit(damage: float) -> void:
	# todo: animations and shit
	if growth_stage != 3:
		# maybe destroy the tree?
		return
	current_hp -= damage
	if current_hp <= 0:
		_fall()
		timer.start()
