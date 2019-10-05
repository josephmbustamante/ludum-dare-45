extends KinematicBody2D

export var speed: int = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play("run")
	else:
		$AnimatedSprite.play("idle")

	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite.flip_h = false

	move_and_slide(velocity)




