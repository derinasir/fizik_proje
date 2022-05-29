extends Control

signal data_changed(data)
signal start(data)

onready var v_spinbox = $Panel/Velocity/Text/SpinBox
onready var v_slider = $Panel/Velocity/HSlider
onready var m_spinbox = $Panel/Mass/SpinBox
onready var a_slider = $Panel/Angle/HSlider
onready var a_predef = $Panel/Predef
onready var a_value = $Panel/Angle/Text/Value
onready var start_button = $Panel/StartButton
onready var reset_button = $Panel/ResetButton
onready var time_label = $Panel/Time
onready var timer = $Panel/Timer

var velocity = 50
var mass = 1
var angle = 0

var elapsed = 0

func _ready():
	v_spinbox.connect("value_changed", self, "_on_velocity_changed")
	v_slider.connect("value_changed", self, "_on_velocity_changed")
	m_spinbox.connect("value_changed", self, "_on_mass_changed")
	a_slider.connect("value_changed", self, "_on_angle_changed")
	
	start_button.connect("pressed", self, "_on_start")
	reset_button.connect("pressed", self, "_on_reset")
	timer.connect("timeout", self, "_on_timer_timeout")

	for child in a_predef.get_children():
		if child is Button:
			var value = str2var(child.name)
			child.connect("pressed", self, "_on_angle_changed", [value])

func _on_velocity_changed(value: float):
	velocity = int(value)
	v_spinbox.value = velocity
	v_slider.value = velocity

func _on_mass_changed(value: float):
	mass = int(value)

func _on_angle_changed(value: float):
	angle = value
	a_slider.value = angle
	a_value.text = var2str(int(value)) + "°"

func _on_start():
	timer.start()
	emit_signal("start", [velocity, angle, mass])

func _on_reset():
	timer.stop()
	elapsed = 0
	get_tree().reload_current_scene()

func _on_timer_timeout():
	elapsed += 0.1

	if elapsed > 60:
		timer.stop()
	time_label.text = "t = " + var2str(elapsed)
