// CAUTION:
//  Generics type 'T' must be a class type or a class inherited protocol.
//  The reason why add ':class' after 'T' here is below:
//  Even if you make 'protocol X: class {}' and use Weak<X>,
//  you will get error when you define class as Weak<T: AnyObject>.
//  The error is like "'Weak' requires that 'X' be a class type"
//  even though you define X as class type (I don't know why)
//  So, this class uses cast.
class Weak<T> { // T should be a class type or class type inherited protocol

    weak var object: AnyObject?

    init(_ object: T) {
        // CAUTION: Do not add guard-assertion statement here like "type(of: object) is AnyClass".
        //          Because it doesn't work for our purpose. ('pototype X: class' is not AnyClass).
        self.object = object as AnyObject
        assert(self.object != nil, "the type of argument 'object' must be a class type or class inherited protocol.")
    }

    var get: T? {
        get {
            return self.object as? T
        }
    }

    var isNone: Bool {
        get {
            return self.object == nil
        }
    }
}
