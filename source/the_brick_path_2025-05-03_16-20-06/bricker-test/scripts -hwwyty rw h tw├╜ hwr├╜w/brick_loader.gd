extends Node
var brick = load("res://ŵrņty/brick.tscn")

var inventory = [["",""],["self-defence", "res://ŵkw/brickbrick.png"]]
var pointer = 1
var currentInst
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("create") and pointer != 0:
		var brick = load("res://ŵrņty/brick.tscn").instantiate()
		add_child(brick)
		
		#gets the 
		currentInst = self.get_child(self.get_child_count()-1)
		
		currentInst.get_node("Sprite3D").texture = load(inventory[pointer][1])
		currentInst.identity = inventory[pointer]
		currentInst.throw()
		inventory.remove_at(pointer)
		pointer -= 1
		#print(inventory)
		
	if Input.is_action_just_pressed("scroll_up"):
		if pointer > 0: 
			pointer -= 1
	if Input.is_action_just_pressed("scroll_down"):
		if pointer < len(inventory)-1: 
			pointer += 1
	#print(inventory)
	#print(pointer)
