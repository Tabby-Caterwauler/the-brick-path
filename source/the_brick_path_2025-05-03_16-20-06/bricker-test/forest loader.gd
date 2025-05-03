extends Node
var Tree1 = load("res://tree1.tscn")
@export var Treecount = 100
var Cur_instance
@export var zRangeMax = 100
@export var xRangeMax = 100
var rng = RandomNumberGenerator.new()
func _ready() -> void:
	for x in range(0,Treecount):
		add_child(Tree1.instantiate())
		
		Cur_instance = self.get_child(self.get_child_count()-1)
		Cur_instance.global_position.y = 20.364
		Cur_instance.global_position.z = rng.randi_range(-zRangeMax, zRangeMax)
		Cur_instance.global_position.x = rng.randi_range(-xRangeMax, xRangeMax)
	print(self.get_children())
