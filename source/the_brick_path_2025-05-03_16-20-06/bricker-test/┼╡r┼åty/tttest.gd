extends Panel
var Shown = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Shown == false:
		set_modulate(lerp(get_modulate(), Color(1,1,1,0), 0.08))
	else:
		set_modulate(lerp(get_modulate(), Color(1,1,1,1), 0.2))
