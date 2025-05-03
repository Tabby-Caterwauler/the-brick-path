extends Label
var is_visible = false

func _process(delta: float) -> void:
	if is_visible == false:
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.2))
	else:
		set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
