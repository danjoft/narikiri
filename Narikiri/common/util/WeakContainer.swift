class WeakContainer<T: AnyObject> {
    var wrappers: [Weak<T>] = []

    // after append, no need to remove due to weak reference.
    func append(_ element: T) {
        wrappers.append(Weak<T>(element))
        removeAllNone()
    }

    func removeIfExists(_ element: T) {
        wrappers = wrappers.filter { !$0.isNone && $0.get !== element }
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
