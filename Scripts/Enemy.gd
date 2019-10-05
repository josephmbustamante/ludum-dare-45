extends KinematicBody2D

export (int) var health = 100

func handle_hit(damage: int):
	health -= damage
	print("Enemy was hit, new health: ", health)
	if health <= 0:
		queue_free()
