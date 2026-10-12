extends Control

@export var id_buttons = 0
@onready var label: Label = $VBoxContainer/Control/Label

func _ready() -> void:
	label.text = str(id_buttons)


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		print("Выбрана зона монтра: ",id_buttons)
	pass # Replace with function body.
