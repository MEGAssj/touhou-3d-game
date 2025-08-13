extends CharacterBody3D

@onready var camera_mount: Node3D = $camera_mount
# mount my nuts to your mouth


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouselockDebounce = true
var sens_mouse = 0.5


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x*sens_mouse))
		camera_mount.rotate_x(deg_to_rad(-event.relative.y*sens_mouse))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	# add my nuts to your mouth
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	# handle my nuts on yo mouth
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# get my nuts on yo mouth
	# As good practice, you should replace UI actions with custom gameplay actions.
	# practice my nuts on your mouth
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	# stupid fucking code to unlock mouse because i was tired of alt-tabbing all the time
	# you jackass
	if Input.is_action_just_pressed("ui_focus_next"):
		print('i fucking hate computers')
		if mouselockDebounce == true:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			mouselockDebounce = false
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			mouselockDebounce = true
			
			
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
