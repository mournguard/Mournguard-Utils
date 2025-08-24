@tool
extends Control

var object: Object
var tag_key: String = "tags"
var get_method: String = "get_tag"
var set_method: String = "set_tag"

var label: String:
	set(_v): %Label.text = _v
	get: return %Label.text
	
var details: String:
	set(_v): 
		%Details.text = _v
		%Details.visible = _v != ""
	get: return %Details.text

var simple: bool:
	set(v): simple = v; _update_display();

func _ready():
	_update_tags()

func _update_display() -> void:
	%Label.visible = !simple
	%HSeparator.visible = !simple
	%Label2.visible = !simple

func _update_tags() -> void:
	for c in %Tags.get_children():
		%Tags.remove_child(c)
		c.queue_free()

	for tag in object.get(tag_key):
		var node = %Tag.duplicate()
		node.text = tag
		node.pressed.connect(_on_remove_tag.bind(tag))
		%Tags.add_child(node)

func _on_add_tag_button() -> void:
	var tag = %LineEdit.text
	if tag == "": return
	_on_add_tag(tag)

func _on_add_tag(tag: String) -> void:
	object.call(set_method, tag, true)
	%LineEdit.text = ""
	%LineEdit.grab_focus()
	_update_tags()

func _on_remove_tag(tag: String) -> void:
	object.call(set_method, tag, false)
	_update_tags()
