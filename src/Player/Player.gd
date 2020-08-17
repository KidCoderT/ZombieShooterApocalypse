extends KinematicBody2D

export (int) var speed = 500
export (float) var friction = 0.9
export (float) var acceleration = 0.3
export (int) var bullet_speed = 1000
export (float) var fire_rate = 0.5

var can_fire = true
var velocity := Vector2()
onready var end_of_gun = $EndOfGun
onready var muzzle_flash_animation = $MuzzleFlashAnimation
onready var bullet = preload("res://src/Player/Bullet.tscn")

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
	
	# Bullet Shooting Mechanic
	if Input.is_action_pressed("fire") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = end_of_gun.get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		muzzle_flash_animation.play("Muzzle Flash")
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

	if dummy_velocity.length() > 0:
		velocity = lerp(velocity, dummy_velocity.normalized() * speed, acceleration)
	else:
		velocity = lerp(velocity, Vector2.ZERO, friction)

	look_at(get_global_mouse_position())
	velocity = move_and_slide(velocity)
