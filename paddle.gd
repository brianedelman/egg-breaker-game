extends RigidBody2D

class_name Paddle

var direction = Vector2.ZERO

@export var speed = 10000 * 10
@export var camera: Camera2D

var camera_rect: Rect2
var half_paddle_width: float

var screen_size # Size of the game window.
var is_ball_started = false

@onready var ball = $"../Ball"
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	ball.life_lost.connect(on_ball_lost)
	camera_rect = camera.get_viewport_rect()
	half_paddle_width = collision_shape_2d.shape.get_rect().size.x / 2 * scale.x
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	linear_velocity = speed * direction * delta
	
func _process(delta):
	var camera_start_x = camera.position.x - camera_rect.size.x / 2
	var camera_end_x = camera.position.x + camera_rect.size.x /2
	
	if global_position.x - half_paddle_width < camera_start_x:
		global_position.x = camera_start_x + half_paddle_width
	elif global_position.x + half_paddle_width > camera_end_x:
		global_position.x = camera_end_x - half_paddle_width

func _input(event):
	# We check for each move input and update the direction accordingly.
	if Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("left"):
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
		
	if direction != Vector2.ZERO && !is_ball_started:
		ball.start_ball()
		is_ball_started = true
		
		
func on_ball_lost():
	is_ball_started = false
	direction = Vector2.ZERO
	
func get_width():
	return $CollisionShape2D.shape.get_rect().size.x
	
