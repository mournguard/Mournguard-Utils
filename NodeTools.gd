@tool
class_name NodeTools

static func Wipe(node: Node, free_children: bool = true) -> void:
	for c in node.get_children():
		node.remove_child(c)
		if free_children: c.queue_free()

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

static func RemoveFromTree(node: Node) -> void:
	var parent: Node = node.get_parent()
	if parent:
		parent.remove_child(node)
