extends Node2D

const wait_duration := 1.0

@onready var platform := $platform as AnimatableBody2D
@export var move_speed := 4.0
@export var distance := 156
@export var move_horizontal := true

var follow := Vector2.ZERO
var platform_center := 16

func _ready() -> void:
	move_platform()

func _physics_process(_delta: float) -> void: 
	platform.position = platform.position.lerp(follow, 0.5)
	
func move_platform():
	var move_direction = Vector2.RIGHT * distance if move_horizontal else Vector2.UP * distance
	var durantion = move_direction.length() / float(move_speed * platform_center)
	
	var platform_tween = create_tween().set_loops()
	platform_tween.tween_property(self, "follow", move_direction, durantion).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(wait_duration)
	platform_tween.tween_property(self, "follow", Vector2.ZERO, durantion).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT).set_delay(wait_duration)
