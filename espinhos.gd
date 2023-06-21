extends StaticBody2D

@onready var animation: AnimationPlayer = get_node("Animation")
@onready var state_timer: Timer = get_node("StateTimer")

var current_state: String = "off"

@export var damage: int

func _ready() -> void:
	state_timer.start()

func _on_state_timer_timeout() -> void:
	state_timer.start()
	
	if current_state == "off":
		current_state = "on"
		animation.play(current_state)
		return
		
	if current_state == "on":
		current_state = "off"
		animation.play(current_state)
		return

func _on_detection_area_body_entered(body) -> void:
	if body.is_in_group("player"):
		body.update_health(global_position, damage)
