extends RigidBody3D
@export var seed:int
@onready var brickpointer:Node3D
@onready var gotopointer = $pointer
@onready var resettimer = $reset
@onready var waittimer = $wait
@onready var chirplayer = $chirp
@onready var chirptimer = $"chirp/chirptimer"
@onready var dieplayer = $die
@export var maxwalktime:float
@export var waitmin:float = 4
@export var waitmax:float = 6
@export var walkmin:float = 5
@export var walkmax:float = 9
@export var SPEED:float = .5

var ismoving:bool = true
const maxrotation = 360
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	brickpointer = get_tree().get_root().get_node("Node3D").get_node("brick_thrower")
	rng.seed = seed
	waittimer.wait_time = rng.randf_range(walkmin, walkmax)
	waittimer.start()
	chirptimer.wait_time = rng.randf_range(9,30)
	chirptimer.start()

func _process(delta: float) -> void:
	if ismoving == true:
		move()
func rotationset():
	self.rotation.y = rng.randi_range(0,maxrotation)
	resettimer.wait_time = rng.randf_range(walkmin, walkmax)
func move():
	translate(Vector3(0,0,SPEED))


func _on_reset_timeout() -> void:
	ismoving = !ismoving
	waittimer.wait_time = rng.randf_range(walkmin, walkmax)
	resettimer.start()


func _on_wait_timeout() -> void:
	ismoving = !ismoving
	rotationset()
	resettimer.wait_time = rng.randf_range(waitmin, waitmax)
	waittimer.start()



func _on_chirptimer_timeout() -> void:
	chirptimer.wait_time = rng.randf_range(9,30)
	chirplayer.play()


func _on_killnox_body_entered(body: Node3D) -> void:
	if body is RigidBody3D:
		dieplayer.play()
		
func become_brick():
	
	var brick = load("res://ŵrņty/brick.tscn").instantiate()
	brickpointer.add_child(brick)
	var currentInst = brickpointer.get_child(brickpointer.get_child_count()-1)
	currentInst.get_node("Sprite3D").texture = load("res://ŵkw/pukeko.png")
	currentInst.identity = ["pukeko", "res://ŵkw/pukeko.png"]
	currentInst.global_position = self.global_position

func _on_die_finished() -> void:
	become_brick()
	self.queue_free()
