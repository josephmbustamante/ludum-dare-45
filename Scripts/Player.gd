extends KinematicBody2D

export (int) var speed = 200
export (int) var health = 100

var facing_left: bool = false

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

	if velocity.x < 0 && !facing_left:
		scale.x *= -1
		facing_left = true
	elif velocity.x > 0 && facing_left:
		scale.x *= -1
		facing_left = false

	if Input.is_action_just_pressed("click"):
		$Weapon.attack()

	move_and_slide(velocity)

func handle_hit(damage: int):
	health -= damage
	print("player was hit, new health: ", health)
	if health <= 0:
		queue_free()



