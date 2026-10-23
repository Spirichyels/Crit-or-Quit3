extends TextureButton
var path_texture_pressed  = preload("res://Assets/SkillsIcons/skills/xz.png")
@onready var timer_cool_down: Timer = $TimerCoolDown


@export var skill_id = 0


var damage = -1
var max_size_x = 50
var max_size_y = 50

var test_x

enum SKILL {
	PRESSED,
	ACTIVE,
	COOLDOWN,
	READY
}

var skill_button_state: int = SKILL.READY:
	set(value):
		skill_button_state = value
		match skill_button_state:
			SKILL.PRESSED:
				pressed_state()
				pass
			SKILL.ACTIVE:
				active_state()
				pass
			SKILL.COOLDOWN:
				cooldown_state()
				pass
			SKILL.READY:
				ready_state()
				pass

func pressed_state():
	pass
func active_state():
	Signals.emit_signal("get_damage_skill", damage)
	print("damage: ", damage)
	skill_button_state = SKILL.COOLDOWN
	pass
func cooldown_state():
	test_x = texture_normal
	texture_normal = path_texture_pressed
	timer_cool_down.start(5)
	
	pass
func ready_state():
	pass


func _ready() -> void:
	
	#texture_normal = text
	pass
	
func getDamageSkill():
	if skill_button_state == SKILL.ACTIVE:
		if damage > -1:
			skill_button_state = SKILL.COOLDOWN
			return damage
			
			
		

func setScale(x):
	scale.x = x
	scale.x = x
	
func setTextures(path):
	var xrt = load(path)
	texture_normal = xrt
	pass
	
func setSkill(id):
	var newSkill = Skills.skills[id]
	texture_normal = load(newSkill.icon.resource_path)
	test_x = texture_normal
	texture_pressed = path_texture_pressed
	damage = newSkill.value
	tooltip_text = newSkill.getDescription()
	


func _on_pressed() -> void:
	#print("Использована способность: ",skill_id)
	if skill_button_state == SKILL.READY:
		skill_button_state = SKILL.ACTIVE
	
	pass # Replace with function body.


func _on_timer_cool_down_timeout() -> void:
	texture_normal= test_x
	skill_button_state = SKILL.READY
	pass # Replace with function body.
