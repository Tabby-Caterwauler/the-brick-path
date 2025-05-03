extends Area3D
class_name Dialog_Scene_Node
@export var name_colour:Color 
@export var next_node:Node
@export var gui_node:Control
@export var person_name:String
func _ready():
	pass

func load_next():
	gui_node.get_node("textbox/name panel").set_name_label(person_name)
	gui_node.get_node("textbox/name panel/NinePatchRect/name").set("theme_override_colors/font_color", name_colour)
	#print(gui_node.get_node("textbox/name panel/NinePatchRect/name").theme.font_color)
	if next_node is Dialog_Text_Node:
		next_node.display_and_load()
