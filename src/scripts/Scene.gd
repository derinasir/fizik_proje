extends Node2D

onready var ball = $Ball1
onready var adjust_vector = $AdjustVector

func _ready():
	adjust_vector.connect("start", self, "on_start")

func on_start(data):
	var angle_radians = deg2rad(-data[1])
	var velocity = Vector2.RIGHT.rotated(angle_radians) * data[0]
	
	ball.velocity = velocity
	ball.mass = data[2]
