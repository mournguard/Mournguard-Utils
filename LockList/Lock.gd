class_name Lock
var name: String

static var MouseOverLock: Lock = Lock.new("MouseOver")
static var PerceptionLock: Lock = Lock.new("Perception")

func _init(_name: String = "") -> void:
	name = _name

func equals(_lock: Lock) -> bool:
	return name == _lock.name
