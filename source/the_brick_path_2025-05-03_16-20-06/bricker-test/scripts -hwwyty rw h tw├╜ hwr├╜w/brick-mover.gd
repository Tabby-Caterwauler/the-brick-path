extends RigidBody3D
var player
var throw_place
var has_fallen = false
var ground_cast
# Called when the node enters the scene tree for the first time.
var identity = []
@export var naturally_spawning = false
@export var given_name:String
@export var given_image:Texture2D
func _ready() -> void:
	if naturally_spawning == true:
		identity = [given_name, given_image.resource_path]
		$Sprite3D.texture = given_image
	ground_cast = get_node("RayCast3D")
	player = get_node("../../player")
	throw_place = get_node("../../player/camera_Pivot/Camera3D/throw_place")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func throw() -> void:
	
	linear_velocity = Vector3(0,0,0)
	global_position = throw_place.global_position
	self.rotation = player.rotation
	apply_force(-basis.z*2000)
	#print(global_position)
	
func _process(delta: float) -> void:
	if has_fallen == false:
		if ground_cast.is_colliding():
			$Audio.play()
			has_fallen = true
	if has_fallen == true:
		if ground_cast.is_colliding() == false:
			has_fallen = false
	if global_position.distance_to(player.global_position) < 4:
		get_node("../").inventory.append(identity)
		get_node("../").pointer = len(get_node("../").inventory)-1 
		Input.action_press("inputs_which_show_inventory")
		Input.action_release("inputs_which_show_inventory")
		self.free()
	
