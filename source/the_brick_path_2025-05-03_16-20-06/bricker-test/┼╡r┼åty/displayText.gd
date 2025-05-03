extends Node
var brickth
@onready var label = $MainPanel/Label
@onready var MainImage = $MainPanel/image
@onready var panel = $MainPanel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	brickth = get_node("../../../brick_thrower")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = brickth.inventory[brickth.pointer][0]
	MainImage.texture = load(brickth.inventory[brickth.pointer][1])
	if Input.is_action_just_pressed("inputs_which_show_inventory"):
		$MainPanel.Shown = true
		$Timer.start()

func _on_timer_timeout() -> void:
	$MainPanel.Shown = false
