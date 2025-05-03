extends CharacterBody3D
const WALKING_SPEED = 10
const RUNNING_SPEED = 100
var SPEED = 10
@export var Gui_control_node:Control


var mouse_sensitivity = .5
@onready var ray = $camera_Pivot/Camera3D/RayCast3D
@onready var interaction_cast = $camera_Pivot/Camera3D/RayCast3D
func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_pressed("running"): SPEED = RUNNING_SPEED
	else: SPEED = WALKING_SPEED
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

	if velocity.is_zero_approx() == false:
		start_walk_audio()
	

	if interaction_cast.get_collider() is Dialog_Scene_Node:
		
		Gui_control_node.get_node('interact_indicator_lable').is_visible = true
		if Input.is_action_just_pressed("interact"):
			interaction_cast.get_collider().load_next()
		
	else:
		Gui_control_node.get_node('interact_indicator_lable').is_visible = false
	
func _unhandled_input(event: InputEvent):
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			self.rotate_y(-event.relative.x * (0.01 * mouse_sensitivity))
			$camera_Pivot.rotate_x(-event.relative.y * (0.01 * mouse_sensitivity))
			$camera_Pivot.rotation.x = clamp($camera_Pivot.rotation.x, deg_to_rad(-70), deg_to_rad(80))
			
#why are these different functions? because if I want multiple 
#walking sounds for different surfaces, the calling will be handled here

func stop_walk_audio():
	pass
func start_walk_audio():
	if $walking_grass.playing == false:
		$walking_grass.play()

func handle_dialog(dialog_node:Dialog_Text_Node):
	pass
