// T should be a class type or class type inherited protocol.
class WeakContainer<T> {
    var wrappers: [Weak<T>] = []

    // after append, no need to remove due to weak reference.
    func append(_ element: T) {
        wrappers.append(Weak<T>(element))
        removeAllNone()
    }

    func removeIfExists(_ element: T) {
        wrappers = wrappers.filter { !$0.isNone && ($0.get as AnyObject) !== (element as AnyObject) }
    }

    func removeAllNone() {
        wrappers = wrappers.filter { !$0.isNone }
    }

    // returns the number of elements removed
    func cleanUp() -> Int {
        let originNumber = wrappers.count
        removeAllNone()
        let numberRemoved = originNumber - wrappers.count
        return numberRemoved
    }

}
