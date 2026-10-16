extends Control

@export var id_buttons = 0
@onready var label: Label = $VBoxContainer/Control/Label
@onready var skin: CharacterBody2D = $VBoxContainer/Control/Skin
@onready var enemie: Control = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $VBoxContainer/Control/Skin/AnimatedSprite2D
@onready var timer_to_block: Timer = $TimerToBlock
@onready var timer_to_attack: Timer = $TimerToAttack

@onready var hp_bar: sp4_ValueProgressBar = $VBoxContainer/Control/Skin/hpBar

#Эти 2 переменные нужны для защиты от 2 клика на телефоне
var _last_click := 0.0
const _CLICK_COOLDOWN := 0.1
#--------------------------------

var isBlocking = false
var onDeath = true
var onReady = true
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
		if current_hp <= 0:
			current_hp = 0
			state = DEATH
	
var max_hp = -1:
	set(value):
		max_hp = value
		hp_bar.max_hp_changed(max_hp)

var state: int = INITIAL:
	set(value):
		state = value
		if (id_buttons == 1):
			print(state)
		match state:
			IDLE:
				#print(state)
				if not onDeath:
					idle_state()
				else:
					fix_state(state)
				pass
			ATTACK:
				#print(state)
				if not onDeath:
					attack_state()
				else:
					fix_state(state)
				pass
			TIME_BLOCK:
				#print(state)
				if not onDeath:
					time_block_state()
				else:
					fix_state(state)
				pass
			DAMAGE:
				#damage_state()
				pass
			DEATH:
				if not onDeath:
					death_state()
					Global.SCORE += 10
				else:
					fix_state(state)
				pass
			REBORN:
				print("onReady: ", onReady, "onDeath: " ,onDeath)
				if onReady:
					reborn_state()
				else:
					print("не могу оживиться")
			INITIAL:
				initial_state()
				

func idle_state():
	onReady = false
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
	onDeath = true
	timer_to_attack.stop()
	timer_to_block.stop()
	animated_sprite_2d.stop()
	animated_sprite_2d.play("DEATH")
	await animated_sprite_2d.animation_finished
	onVisible = false
	onReady = true
	pass
func reborn_state():
	print("reborn_state")
	onVisible = false
	
	animated_sprite_2d.stop()
	
	max_hp = 10 + Global.DIFFICULTY
	current_hp = max_hp
	onDeath = false

	
	state = IDLE
	onVisible = true
	
func initial_state():
	animated_sprite_2d.stop()
	onDeath = true
	onVisible = false
	
func fix_state(_state):
	print(state ," не сработал")

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
	if state != DEATH and onDeath == false and onReady == false:
		timer_to_block.stop()
		if not onDeath:
			state = IDLE


func _on_timer_to_block_timeout() -> void:
	if state != DEATH and onDeath == false and onReady == false:
		_stop_block()
		if !isBlocking:
			if not onDeath:
				print(id_buttons,": Нанес урон")
				Global.PLAYER_CURRENT_HP -= 1
			else:
				print(id_buttons,": Пытается бить мертвым, но у него ничего не выходит")
		isBlocking = false
			
	pass # Replace with function body.



func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_handle_click()
	elif event is InputEventScreenTouch and event.pressed:
		_handle_click()
	pass

func _handle_click():
	if state != DEATH and onDeath == false and onReady == false:
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


func _on_timer_to_attack_timeout() -> void:
	if state == IDLE and onDeath == false and onReady == false:
		state = ATTACK
	pass # Replace with function body.
