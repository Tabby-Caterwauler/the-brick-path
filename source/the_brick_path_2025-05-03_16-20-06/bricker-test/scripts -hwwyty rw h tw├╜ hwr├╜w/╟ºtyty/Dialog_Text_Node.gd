extends Node
class_name Dialog_Text_Node
@export var dialog_text:String
@export var Next_node:Node
@export var gui_node:Control
#var is_done_reading = false
func display_and_load() -> void:
	if gui_node.get_node("textbox").dialog_overflowing == false and  gui_node.get_node("textbox").is_reading == false:
		
		gui_node.get_node("textbox").is_visible = true
		gui_node.get_node("textbox").read_text(dialog_text)
	
		await gui_node.get_node("textbox").is_done
		load_next()

func load_next() -> void:
	if Next_node is Dialog_Text_Node:
		Next_node.display_and_load()
	else:
		gui_node.get_node("textbox").is_visible = false
		pass
