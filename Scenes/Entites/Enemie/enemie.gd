extends Control

@export var id_buttons = 0
@onready var label: Label = $VBoxContainer/Control/Label
@onready var skin: CharacterBody2D = $VBoxContainer/Control/Skin
@onready var enemie: Control = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $VBoxContainer/Control/Skin/AnimatedSprite2D
@onready var timer_to_block: Timer = $TimerToBlock
@onready var timer_to_attack: Timer = $TimerToAttack

@onready var hp_bar: sp4_ValueProgressBar = $VBoxContainer/Control/Skin/hpBar


var isBlocking = false
var onDeath = true
var onVisible = false:
	set(value):
		onVisible = value
		skin.visible = onVisible

enum {
	IDLE,
	ATTACK,
	TIME_BLOCK,
	DAMAGE,
	DEATH,
	REBORN,
	INITIAL
}

var current_hp = -1:
	set(value):
		current_hp = value
		hp_bar.current_hp_changed(current_hp)
		if current_hp == 0:
			state = DEATH
	
var max_hp = -1:
	set(value):
		max_hp = value
		hp_bar.max_hp_changed(max_hp)

var state: int = INITIAL:
	set(value):
		state = value
		match state:
			IDLE:
				#print(state)
				if not onDeath:
					idle_state()
				pass
			ATTACK:
				#print(state)
				if not onDeath:
					attack_state()
				pass
			TIME_BLOCK:
				#print(state)
				if not onDeath:
					time_block_state()
				pass
			DAMAGE:
				#damage_state()
				pass
			DEATH:
				if not onDeath:
					death_state()
					Global.SCORE += 10
				pass
			REBORN:
				reborn_state()
			INITIAL:
				initial_state()
				

func idle_state():
	timer_to_attack.start(1)
	animated_sprite_2d.play("IDLE")
func attack_state():
	animated_sprite_2d.play("ATTACK")
	await animated_sprite_2d.animation_finished
	if not onDeath:
		state = TIME_BLOCK
	else:
		state = DEATH
func time_block_state():
	animated_sprite_2d.play("TIME_BLOCK")
	timer_to_block.start(randf_range(1.0, 3.0))
	pass
func death_state():
	timer_to_attack.stop()
	timer_to_block.stop()
	onDeath = true
	animated_sprite_2d.stop()
	animated_sprite_2d.play("DEATH")
	await animated_sprite_2d.animation_finished
	onVisible = false
	pass
func reborn_state():
	animated_sprite_2d.stop()
	
	max_hp = 10
	current_hp = 10

	onDeath = false
	state = IDLE
	onVisible = true
	
func initial_state():
	animated_sprite_2d.stop()
	onDeath = true
	onVisible = false
	


func _ready() -> void:
	label.text = str(id_buttons)
	skin.position.x = enemie.size.x/2
	skin.position.y = enemie.size.y/2
	max_hp = 10
	current_hp = 10

	


func update_sizes() -> void: # вызывается сверху
	skin.position.x = enemie.size.x/2 #- skin.getSize().x/2
	skin.position.y = enemie.size.y/2 #- skin.getSize().y/2
	#print(skin.position.x )

	pass

func _stop_block():
	timer_to_block.stop()
	state = IDLE


func _on_timer_to_block_timeout() -> void:
	_stop_block()
	if !isBlocking:
		print(id_buttons,": Нанес урон")
		Global.PLAYER_CURRENT_HP -= 1
	isBlocking = false
		
	pass # Replace with function body.


#func _on_control_gui_input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("mouse_left"):
		#if state == TIME_BLOCK:
			#isBlocking = true
			#_stop_block()
			#print("Увернулся от ",id_buttons)
		#isBlocking = false		
		##print("Выбрана зона монтра: ",id_buttons)
	#pass

var _last_click := 0.0
const _CLICK_COOLDOWN := 0.1



func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_handle_click()
	elif event is InputEventScreenTouch and event.pressed:
		_handle_click()
	pass

func _handle_click():
	var now = Time.get_ticks_msec() / 1000.0
	if now - _last_click < _CLICK_COOLDOWN:
		return
	_last_click = now
	
	if state == TIME_BLOCK:
		isBlocking = true
		_stop_block()
		print("Увернулся от ", id_buttons)
	else:
		current_hp -= 1
	isBlocking = false

#func _on_color_rect_gui_input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("mouse_left"):
		#if state == TIME_BLOCK:
			#isBlocking = true
			#_stop_block()
			#print("Увернулся от ",id_buttons)
		#else:
			#current_hp -= 1
		#isBlocking = false
		#
		##print("Выбрана зона монтра: ",id_buttons)
	#pass

func _on_timer_to_attack_timeout() -> void:
	if state == IDLE and onDeath == false:
		state = ATTACK
	pass # Replace with function body.
