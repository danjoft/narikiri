protocol ChatMessage: class {
    var id: Int { get }
    var order: Int { get }
    var chara: ChatChara { get }
    var text: String { get }

    var isIdFixed: Bool { get }
}

extension ChatMessage {
    var isIdFixed: Bool {
        get {
            return ChatModelSpecialIDs.isFixedId(id: self.id)
        }
    }
}


protocol MutableChatMessage : ChatMessage {
    var id: Int { get set }
    var order: Int { get set }
    var chara: ChatChara { get set }
    var text: String { get set }

    var isDirty: Bool { get }
    func clearDirty()
}

internal class MutableChatMessageImpl : MutableChatMessage {
    private var _id: Int
    private var _order: Int
    private var _chara: ChatChara
    private var _text: String

    private var _isDirty: Bool

    init(id: Int, order: Int, chara: ChatChara, text: String) {
        _id = id
        _order = order
        _chara = chara
        _text = text
        _isDirty = false
    }

    var id: Int {
        get {
            return _id
        }
        set {
            assert(!isIdFixed, "Shouldn't assign to the already fixed id")
            _id = newValue
            _isDirty = true
        }
    }

    var order: Int {
        get {
            return _order
        }
        set {
            if _order == newValue {
                return
            }
            _order = newValue
            _isDirty = true
        }
    }

    var chara: ChatChara {
        get {
            return _chara
        }
        set {
            if ChatModelSpecialIDs.isFixedId(id: newValue.id) &&
                _chara.id == newValue.id {
                return
            }
            _chara = newValue
            _isDirty = true
        }
    }

    var text: String {
        get {
            return _text
        }
        set {
            if _text == newValue {
                return
            }
            _text = newValue
            _isDirty = true
        }
    }

    var isDirty: Bool {
        get {
            return _isDirty
        }
    }

    func clearDirty() {
        assert(isDirty, "Need not clear dirty due to clean.")
        _isDirty = false
    }
}
