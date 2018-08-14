class WeakContainer<T: AnyObject> {
    var list: [Weak<T>] = []

    func append(_ element: T) {
        list.append(Weak<T>(element))
        removeAllNone()
    }

    func removeAllNone() {
        list = list.filter { (element: Weak<T>) in
            return !element.isNone
        }
    }

    // returns the number of elements removed
    func cleanUp() -> Int {
        let originNumber = list.count
        removeAllNone()
        let numberRemoved = originNumber - list.count
        return numberRemoved
    }

}
