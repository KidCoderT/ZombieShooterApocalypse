extends KinematicBody2D

export (int) var speed = 500

func _process(delta):
	var movement_direction := Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		movement_direction.y -= 1
	if Input.is_action_pressed("Down"):
		movement_direction.y += 1
	if Input.is_action_pressed("Left"):
		movement_direction.x -= 1
	if Input.is_action_pressed("Right"):
		movement_direction.x += 1
	
	movement_direction = movement_direction.normalized()
	look_at(get_global_mouse_position())
	move_and_slide(movement_direction * speed)
