@tool
class_name MouseAnchorLine extends TextureRect

@export var origin: Vector2:
	set(v):
		origin = v
		_update()

@export var target: Vector2:
	set(v):
		target = v
		_update()

var new: bool = false

func _ready() -> void:
	new = true

func _update() -> void:
	visible = new
	position = origin
	size.x = origin.distance_to(target)
	rotation = origin.angle_to_point(target)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		target = event.position
