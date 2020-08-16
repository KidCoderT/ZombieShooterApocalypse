extends KinematicBody2D

export (int) var speed = 500
export (float) var friction = 0.9
export (float) var acceleration = 0.3

var velocity := Vector2()

func _physics_process(delta):
	var dummy_velocity := Vector2()
	
	if Input.is_action_pressed("Up"):
		dummy_velocity.y -= 1
	if Input.is_action_pressed("Down"):
		dummy_velocity.y += 1
	if Input.is_action_pressed("Left"):
		dummy_velocity.x -= 1
	if Input.is_action_pressed("Right"):
		dummy_velocity.x += 1

	if dummy_velocity.length() > 0:
		velocity = lerp(velocity, dummy_velocity.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)

	look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity)
