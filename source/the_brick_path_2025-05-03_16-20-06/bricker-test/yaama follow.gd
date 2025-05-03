extends Node3D
var player
var times_hit = 0
@export var Rotate_up:bool = true
@export var Set_speed:float = 0.2
var SPEED:float = 0.1
var mode:int = 1
func _ready():
	SPEED = Set_speed
	#print(get_tree().get_root().get_node("Node3D").get_node("player"))
	player = get_tree().get_root().get_node("Node3D").get_node("player")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	look_at(player.position)
	if Rotate_up == false: self.rotation.z = 0
	
	if global_position.distance_to(player.global_position) < 5:
		mode = 2
		SPEED = 0.8
	if global_position.distance_to(player.global_position) > 50:
		mode = 1
		SPEED = Set_speed
	if mode == 1:
		# if you set this to translate(vector3(SPEED,0,0) it would move around you in a circle!
		translate(Vector3(0,0,-SPEED))
	#print(rotation, " : ", position)
	if mode == 2:
		# if you set this to translate(vector3(SPEED,0,0) it would move around you in a circle!
		pass
		#translate(Vector3(SPEED,0,-0.00))

	if times_hit == 10:
		$Sprite3D.texture = load("res://ŵkw/wiegie.png")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		body.look_at(player.position)
		body.rotation.z = -body.rotation.z
		body.apply_force(-basis.z*2500)
		body.apply_force(basis.y*500)
		times_hit += 1
