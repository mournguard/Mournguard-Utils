class_name DictionaryTools extends Node

static func WithoutKeys(dict: Dictionary, keys: Array) -> Dictionary:
	var new_dict := {}
	for key: Variant in dict:
		if not keys.has(key):
			new_dict[key] = dict[key]
	return new_dict
