extends CharacterBody2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D



enum {
	IDLE,
	ATTACK,
	TIME_BLOCK,
	DAMAGE,
	DEATH
}

var state: int = 0:
	set(value):
		state = value
		match state:
			IDLE:
				idle_state()
				pass
			ATTACK:
				attack_state()
				pass
			TIME_BLOCK:
				time_block_state()
				pass
			DAMAGE:
				#damage_state()
				pass
			DEATH:
				#death_state()
				pass

func getSize():
	return collision_shape_2d.shape.get_size()
	
func play(anim):
	$AnimatedSprite2D.play(anim)
	
func idle_state():
	$AnimatedSprite2D.play("IDLE")
func attack_state():
	$AnimatedSprite2D.play("ATTACK")
func time_block_state():
	$AnimatedSprite2D.play("TIME_BLOCK")
