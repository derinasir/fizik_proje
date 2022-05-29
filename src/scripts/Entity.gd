extends KinematicBody2D

const UP := Vector2.UP

export(float) var mass = 1
export(float) var gravity = 9.8

var velocity: Vector2
var momentum: Vector2

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
	velocity = move_and_slide(velocity)
