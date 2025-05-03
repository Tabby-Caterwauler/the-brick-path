extends Node3D
@export var brickpointer:Node3D
func _process(delta: float) -> void:
	if Input.is_action_pressed("show_textbox"):
			var brick = load("res://ŵrņty/brick.tscn").instantiate()
			brickpointer.add_child(brick)
			var currentInst = brickpointer.get_child(brickpointer.get_child_count()-1)
			currentInst.get_node("Sprite3D").texture = load("res://ŵkw/pukeko.png")
			currentInst.identity = ["pukeko", "res://ŵkw/brickbrickoldver.png"]
			currentInst.global_position = self.global_position
