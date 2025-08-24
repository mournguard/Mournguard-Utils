@tool
class_name SaveMeshesEditorScenePostImport extends EditorScenePostImport

func _post_import(scene: Node) -> Object:
	var children := scene.get_children()
	for child in children:
		if child is MeshInstance3D:
			var path := get_source_file() + "." + child.name + ".tres"
			ResourceSaver.save(child.mesh, path)
			var saved_mesh := ResourceLoader.load(path)
			child.mesh = saved_mesh
	return scene
