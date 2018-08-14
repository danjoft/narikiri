// Usage:
//  let delegateMap = DelegateMap<EventType, SourceChangeDelegate>()
//  delegateMap.addDelegate(.changed, self)
//  ...
//  delegateMap.forEachDelegate(.changed) { $0.onChanged() }
//
// Caution:
//  T should be a class type or class type inherited protocol.
class DelegateMap<Key: Hashable, T> {
    private var _map: [Key : WeakContainer<T>] = [:]

    // delegate will be holded with weak reference (so no need to remove).
    func addDelegate(key: Key, delegate: T) -> Void {
        _getDelegateContainer(key).append(delegate)
    }

    func removeDelegate(key: Key, delegate: T) -> Void {
        _getDelegateContainer(key).removeIfExists(delegate)
    }

    func forEachDelegate(key: Key, eachDelegateFunc: (T) -> Void) {
        for eachWrapper in _getDelegateContainer(key).wrappers {
            if let delegate = eachWrapper.get {
                eachDelegateFunc(delegate)
            }
        }
    }

    func count(of key: Key) -> Int {
        let container = _getDelegateContainer(key)
        return container.wrappers.count
    }

    private func _getDelegateContainer(_ key: Key) -> WeakContainer<T> {
        if _map[key] == nil {
            _map[key] = WeakContainer<T>()
        }
        let container = _map[key]!
        container.removeAllNone()
        return container
    }
}
