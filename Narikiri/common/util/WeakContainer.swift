class WeakContainer<T: AnyObject> {
    var list: [Weak<T>] = []

    // after append, no need to remove due to weak reference.
    func append(_ element: T) {
        list.append(Weak<T>(element))
        removeAllNone()
    }

    func removeIfExists(_ element: T) {
        list = list.filter { !$0.isNone && $0.get !== element }
    }

    func removeAllNone() {
        list = list.filter { !$0.isNone }
    }

    // returns the number of elements removed
    func cleanUp() -> Int {
        let originNumber = list.count
        removeAllNone()
        let numberRemoved = originNumber - list.count
        return numberRemoved
    }

}
