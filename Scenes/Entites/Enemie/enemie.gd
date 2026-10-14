extends Control

@export var id_buttons = 0
@onready var label: Label = $VBoxContainer/Control/Label
@onready var skin: CharacterBody2D = $VBoxContainer/Control/Skin
@onready var enemie: Control = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $VBoxContainer/Control/Skin/AnimatedSprite2D
@onready var timer_to_block: Timer = $TimerToBlock

var isBlocking = false

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
				#print(state)
				idle_state()
				pass
			ATTACK:
				#print(state)
				attack_state()
				pass
			TIME_BLOCK:
				#print(state)
				time_block_state()
				pass
			DAMAGE:
				#damage_state()
				pass
			DEATH:
				#death_state()
				pass

func idle_state():
	animated_sprite_2d.play("IDLE")
func attack_state():
	animated_sprite_2d.play("ATTACK")
	await animated_sprite_2d.animation_finished
	state = TIME_BLOCK
func time_block_state():
	animated_sprite_2d.play("TIME_BLOCK")
	timer_to_block.start(randf_range(1.0, 3.0))
	pass



func _ready() -> void:
	label.text = str(id_buttons)
	skin.position.x = enemie.size.x/2
	skin.position.y = enemie.size.y/2


func update_sizes() -> void: # вызывается сверху
	skin.position.x = enemie.size.x/2 #- skin.getSize().x/2
	skin.position.y = enemie.size.y/2 #- skin.getSize().y/2
	#print(skin.position.x )

	pass

func _test():
	timer_to_block.stop()
	state = IDLE



func _on_color_rect_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		if state == TIME_BLOCK:
			isBlocking = true
			_test()
			print("Увернулся от ",id_buttons)
			isBlocking = false
			
		#print("Выбрана зона монтра: ",id_buttons)
		pass
	pass # Replace with function body.


func _on_timer_to_block_timeout() -> void:
	_test()
	if !isBlocking:
		print(id_buttons,": Нанес урон")
		Global.PLAYER_CURRENT_HP -= 1
	isBlocking = false
		
	pass # Replace with function body.
