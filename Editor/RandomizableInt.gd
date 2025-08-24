extends EditorProperty

const CONTROL = preload("res://addons/Mournguard-Utils/Editor/RandomizableInt.tscn")
var control: Control

var value: String:
	set(v): control.get_node("%Value").text = v
	get: return control.get_node("%Value").text

func _init():
	control = CONTROL.instantiate()
	control.get_node("%Button").pressed.connect(_on_button_pressed)
	add_child(control)

func _on_button_pressed():
	emit_changed(get_edited_property(), randi())

func _update_property():
	value = str(get_edited_object()[get_edited_property()])
