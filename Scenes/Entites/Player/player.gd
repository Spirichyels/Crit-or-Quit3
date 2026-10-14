extends Control

@onready var helth_potion_bar: sp4_ValueProgressBar = $HBoxContainer/VBoxContainer/HelthPotionBar


func _ready() -> void:
	Global.connect("hp_changed", Callable(self, "_hp_changed"))

func _hp_changed():
	helth_potion_bar.max_hp_changed(Global.PLAYER_MAX_HP)
	helth_potion_bar.current_hp_changed(Global.PLAYER_CURRENT_HP)
	
	
