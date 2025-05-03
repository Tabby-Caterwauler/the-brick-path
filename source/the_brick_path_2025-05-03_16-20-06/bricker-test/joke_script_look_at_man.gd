extends Node3D
var player
@export var Rotate_up:bool = true
func _ready():
	
	player = get_tree().get_root().get_node("Node3D").get_node("man")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(player.position)
	if Rotate_up == false: self.rotation.z = 0
