
class Weak<T: AnyObject> {

    weak var object: T?

    init(_ object: T?) {
        self.object = object
    }

    var get: T? {
        get {
            return self.object
        }
    }

    var isNone: Bool {
        get {
            return self.object == nil
        }
    }
}
