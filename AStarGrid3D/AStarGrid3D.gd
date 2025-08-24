@tool
class_name AStarGrid3D extends AStar3D
## A 3D astar grid for simplified usage, similar to AStarGrid2D

var _points_meta := []
var _data := {}
var _dirty := true
var size: Vector3i:
	set(v): size = v; _update()

func _init(_size: Vector3i, _meta: Dictionary) -> void:
	size = _size
	init_meta(_meta)

func _update() -> void:
	clear()
	var grid_size := YardMagic.GridSize(size)
	for i in grid_size:
		add_point(i, YardMagic.ItoXYZ(i, size))
	for i in grid_size:
		var pos := YardMagic.ItoXYZ(i, size)
		for dir in YardMagic.GridNeighbors(pos, size):
			connect_points(i, YardMagic.XYZtoI(pos + dir, size))
	_dirty = true

func init_meta(_meta: Dictionary) -> void:
	_points_meta = []
	_points_meta.resize(size.z * size.y * size.x)
	for i in _points_meta.size():
		_points_meta[i] = _meta.duplicate(true)
	_dirty = true

func set_point_meta(point: Vector3i, key: String, value: Variant) -> void:
	if not YardMagic.IsInGrid(point, size): return
	_points_meta[YardMagic.XYZtoI(point, size)][key] = value
	_dirty = true

func get_point_meta(point: Vector3, key: String) -> Variant:
	if not YardMagic.IsInGrid(point, size): return
	return _points_meta[YardMagic.XYZtoI(point, size)].get(key, null)

func get_set_point_meta(point: Vector3, key: String, value: Variant) -> Variant:
	if not YardMagic.IsInGrid(point, size): return
	var val: Variant = _points_meta[YardMagic.XYZtoI(point, size)].get(key, null)
	_points_meta[YardMagic.XYZtoI(point, size)][key] = value
	_dirty = true
	return val

func clear_meta_keys(keys: Array) -> void:
	for i in _points_meta.size():
		for key: String in keys:
			_points_meta[i][key] = null
	_dirty = true

func get_path(from: Vector3, to: Vector3) -> PackedVector3Array:
	if YardMagic.IsInGrid(from, size) and YardMagic.IsInGrid(to, size):
		return get_point_path(YardMagic.XYZtoI(from, size), YardMagic.XYZtoI(to, size))
	else: return PackedVector3Array()

func set_weight(pos: Vector3, weight: float) -> void:
	if YardMagic.IsInGrid(pos, size):
		set_point_weight_scale(YardMagic.XYZtoI(pos, size), weight)
		_dirty = true

func get_data() -> Dictionary:
	if _dirty:
		var out := {}
		for i in YardMagic.GridSize(size):
			var pos := YardMagic.ItoXYZ(i, size)
			out[i] = {
				"position": pos
			}
			for meta: String in _points_meta[i]:
				out[i][meta] = _points_meta[i][meta]
		_data = out
		_dirty = false

	return _data

func set_data(data: Dictionary) -> void:
	if not data.size() == size.x * size.y * size.z:
		return

	for i in data.size():
		var new_data: Dictionary = data[i].duplicate(true)
		new_data.erase("position")
		_points_meta[i] = new_data

	_dirty = true
