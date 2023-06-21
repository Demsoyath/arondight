extends CharacterBody2D

var SPEED = 80
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var Player
var chase = false

func _ready():
	get_node("AnimatedSprite2D").play("IdleM")

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if chase:
		if get_node("AnimatedSprite2D").animation != "DeathM":
			get_node("AnimatedSprite2D").play("RunM")
		
		Player = get_node("../../Player/Player")
		var direction = (Player.global_position - global_position).normalized()
		
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "DeathM":
			get_node("AnimatedSprite2D").play("IdleM")
		
		velocity.x = 0
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		body.health -= 2

func death():
	chase = false
	get_node("AnimatedSprite2D").play("DeathM")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
