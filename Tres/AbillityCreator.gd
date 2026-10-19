@tool
extends Resource
class_name AbilityCreator


@export var id: int
@export var name: String
@export var level: int = 1
@export var koef: float
@export var value: int
@export var description: String
@export var description_2: String
@export var icon: Texture2D
@export var current_level: int = 1

func _init() -> void:
	pass

func getDescription() -> String:
	var _description = description + " " +  str(calculate_value()) + " " + description_2
	return _description


func calculate_value() -> float:
	var result = value
	return result
