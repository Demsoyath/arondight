extends CharacterBody2D

var health = 10
var is_attacking = false
const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@export var damage : int = 10
@export var player: CharacterBody2D = null

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("animator")
var current_animation = ""
var is_idle = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		current_animation = "jump"

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction == -1:
		get_node("anim").flip_h = true
	elif direction == 1:
		get_node("anim").flip_h = false

	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0 and current_animation != "attack":
			if current_animation != "runn":
				anim.play("runn")
				current_animation = "runn"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and current_animation != "attack":
			if current_animation != "idle":
				anim.play("idle")
				current_animation = "idle"
				is_idle = true

	move_and_slide()

	attack()

func attack():
	if Input.is_action_just_pressed("ataque1") and current_animation != "attack":
		if velocity.y == 0:
			is_attacking = true
			anim.play("attack")
			current_animation = "attack"

	if current_animation == "attack" and !anim.is_playing():
		is_attacking = false
		if velocity.y == 0:
			if is_idle:
				anim.play("idle")
				current_animation = "idle"
			else:
				anim.play("runn")
				current_animation = "runn"

	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://Levels/menu.tscn")

func update_health(target_position: Vector2, damage: int) -> void:
	health = clamp(health - damage, 0, 10)
