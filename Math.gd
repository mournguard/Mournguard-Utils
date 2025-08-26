class_name Math extends Node

static func ItoXY(i: int, size: Vector2) -> Vector2:
	@warning_ignore("integer_division")
	var y := i / int(size.x)
	var x := i % int(size.x)
	return Vector2(x,y)

static func XYtoI(xy: Vector2, size: Vector2) -> int:
	@warning_ignore("narrowing_conversion")
	return xy.y * size.x + xy.x

static func ItoXYZ(i: int, size: Vector3) -> Vector3:
	@warning_ignore("integer_division")
	var z := i / int(size.y * size.x)
	i -= int(z * (size.y * size.x))
	@warning_ignore("integer_division")
	var y := i / int(size.x)
	var x := i % int(size.x)
	return Vector3(x,y,z)

static func XYZtoI(xyz: Vector3, size: Vector3) -> int:
	@warning_ignore("narrowing_conversion")
	return xyz.z * (size.y * size.x) + xyz.y * size.x + xyz.x
