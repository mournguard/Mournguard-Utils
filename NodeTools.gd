@tool
class_name NodeTools

static func Wipe(node: Node) -> void:
	for c in node.get_children():
		node.remove_child(c)
		c.queue_free()

static func GetFirstChildOfType(node:Node, type: Variant) -> Node:
	for c in node.get_children():
		if is_instance_of(c, type):
			return c
	return null

static func GetFirstAncestorOfType(node: Node, type: Variant) -> Node:
	while not is_instance_of(node, type):
		node = node.get_parent()
		if not node: break
	return node
