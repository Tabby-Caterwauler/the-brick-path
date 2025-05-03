extends Panel
@onready var NameLabel = $"NinePatchRect/name"
func set_name_label(text:String):
	NameLabel.text = text
func set_name_color(color: Color):
	NameLabel.font_color = color
func _process(delta: float) -> void:
	#print(NameLabel.size.y)
	self.size.x = NameLabel.size.x + 15
