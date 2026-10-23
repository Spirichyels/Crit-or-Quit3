extends Control
@onready var enemie_9: Control = $MC/VBC/LineTop/Enemie9
@onready var enemie_8: Control = $MC/VBC/LineTop/Enemie8
@onready var enemie_7: Control = $MC/VBC/LineTop/Enemie7
@onready var enemie_6: Control = $MC/VBC/LineCenter/Enemie6
@onready var enemie_5: Control = $MC/VBC/LineCenter/Enemie5
@onready var enemie_4: Control = $MC/VBC/LineCenter/Enemie4
@onready var enemie_3: Control = $MC/VBC/LineDown/Enemie3
@onready var enemie_2: Control = $MC/VBC/LineDown/Enemie2
@onready var enemie_1: Control = $MC/VBC/LineDown/Enemie1

@onready var timer_on_attack: Timer = $TimerOnAttack

@onready var skills_bar: HBoxContainer = $"../SkillsBar"



var enemies = []
enum ENEMY {
	IDLE,
	ATTACK,
	TIME_BLOCK,
	DAMAGE,
	DAMAGE_SKILLS,
	DEATH,
	REBORN,
	INITIAL
}



func _ready() -> void:
	Signals.connect("get_damage_skill", Callable(self, "_getDamageSkills"))
	enemies.push_front(enemie_9)
	enemies.push_front(enemie_8)
	enemies.push_front(enemie_7)
	enemies.push_front(enemie_6)
	enemies.push_front(enemie_5)
	enemies.push_front(enemie_4)
	enemies.push_front(enemie_3)
	enemies.push_front(enemie_2)
	enemies.push_front(enemie_1)
	
	await get_tree().process_frame
	for i in enemies:
		#print(i.size.x) #размер Enemy
		i.update_sizes()
		i.state = ENEMY.INITIAL
		#print("onDeath: ",i.onDeath)
		
func _getDamageSkills(damage):
	print("_getDamageSkills")
	for enemy in enemies:
		enemy.getDamageSkills(damage)

func _process(delta: float) -> void:
	#print(randi_range(0,8))
	pass
	#print(enemie_1.size)
	#for i in enemies:
		#print(i.size.x)
		#i.update_sizes()
		
	


func _on_timer_on_attack_timeout() -> void:
	#print(timer_on_attack.wait_time)
	timer_on_attack.wait_time = randi_range(1,8)
	#print("_on_timer_on_attack_timeout")
	#enemies[randi_range(0,8)].state = ATTACK
	var enemy = enemies[randi_range(0,8)]
	#var enemy = enemies[0]
	
	if enemy.onDeath:
		if enemy.onReady:
			enemy.state = ENEMY.REBORN
	
	pass # Replace with function body.


func _on_timer_on_diffculty_timeout() -> void:
	Global.DIFFICULTY +=1
	pass # Replace with function body.
