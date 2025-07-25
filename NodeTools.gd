@tool
class_name NodeTools

static func Wipe(node: Node) -> void:
	for c in node.get_children():
		node.remove_child(c)
		c.queue_free()

static func GetFirstChildOfType(node:Node, property: Variant) -> Node:
	for c in node.get_children():
		if is_instance_of(c, property):
			return c
	return null
