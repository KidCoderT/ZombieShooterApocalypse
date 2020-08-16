extends RigidBody2D

func _ready():
	$KillTimer.start()

func _on_KillTimer_timeout():
	queue_free()
