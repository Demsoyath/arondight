extends CharacterBody2D
class_name AA

export(Resource) var PlayerMovement

var velocity = Vector2.ZERO
var Buffered_Jump = false
var is_attacking = false


onready var Jump_Buffer_Timer: = $jumpBufferTimer
onready var remoteTransform2D: = $RemoteTransform2D

func _physics_process(_delta):

	var input = Vector2.ZERO
	input.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_state(input)

func move_state(input):
	apply_gravity()
	if input.x == 0 and is_attacking == false:
		apply_friction()
		anim.play("idle")
	else:
		apply_acceleration(input.x)
		if is_on_floor() and is_attacking == false:
			anim.play("run")
		if input.x > 0:
			anim.flip_h = false
		elif input.x < 0:
			anim.flip_h = true

	attack()

	if is_on_floor():
		reset_double_jump()
	if can_jump():
		jump_input()
	else:
		if is_attacking == false:
			anim.play("jump")
			input_jump_realese()
			input_double_jump()
			buffered_jump()
			fast_fall()


	velocity = move_and_slide(velocity, Vector2.UP)

func attack():
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		anim.play("attack")

func _on_AnimatedSprite_animation_finished():
	if anim.animation == "attack":
			is_attacking=false
