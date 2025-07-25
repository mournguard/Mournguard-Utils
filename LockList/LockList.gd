class_name LockList

signal locked
signal unlocked

var _locks: Array[Lock]

var is_locked: bool:
	get(): return !!_locks.size()

func lock(_lock: Lock) -> bool:
	var i := _locks.find_custom(func(l: Lock) -> bool: return l.equals(_lock))
	if i == -1: _locks.append(_lock)
	if !_locks.is_empty(): locked.emit()
	return i == -1

func unlock(_lock: Lock) -> bool:
	var i := _locks.find_custom(func(l: Lock) -> bool: return l.equals(_lock))
	if i != -1: _locks.remove_at(i)
	if _locks.is_empty(): unlocked.emit()
	return i != -1

func has(_lock: Lock) -> bool:
	return _locks.find_custom(func(l: Lock) -> bool: return l.equals(_lock)) != -1
