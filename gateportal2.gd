extends Area2D

@export var scene_path: String = ""

func _on_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://Levels/world_04.tscn")
		
		body.set_physics_process(false)
