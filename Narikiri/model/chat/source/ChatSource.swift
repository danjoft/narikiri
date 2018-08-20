protocol ChatSourceControlable :
    ChatSourceGettable,
    ChatSourceMessageUpdatable,
    ChatSourceDelegateRegisterable
{}

// TODO: Add ChatSourceRoomUpdatable, ChatSourceCharasUpdatable

class ChatSource: ChatSourceControlable {
    var room: ChatRoom
    var charas: [ChatChara]
    var _messages: [MutableChatMessage]
    var messages: [ChatMessage] {
        get {
            return _messages as [ChatMessage]
        }
    }

    private var _delegateMap = DelegateMap<ChatSourceEventType, ChatSourceDelegate>()
    private var _messageCreator: ChatMessageCreatable

    init(room: ChatRoom, charas: [ChatChara], messages: [MutableChatMessage], messageCreator: ChatMessageCreatable) {
        self.room = room
        self.charas = charas
        _messages = messages
        _messageCreator = messageCreator
    }

    private func _onChanged(key: ChatSourceEventType) {
        assert(key != .changed, "should set any concrete type because .changed is to be dispatched automatically")
        // notifies respectively
        _delegateMap.forEachDelegate(key: key) { $0.onChatSourceChanged(eventType: key) }
        // notifies totally changed
        _delegateMap.forEachDelegate(key: .changed) { $0.onChatSourceChanged(eventType: .changed) }
    }
}

// ChatSourceDelegateRegisterable protocol funcs
extension ChatSource {
    func addDelegate(key: ChatSourceEventType, delegate: ChatSourceDelegate) {
        _delegateMap.addDelegate(key: key, delegate: delegate)
    }
    func removeDelegate(key: ChatSourceEventType, delegate: ChatSourceDelegate) {
        _delegateMap.removeDelegate(key: key, delegate: delegate)
    }
}

// ChatSourceMessageUpdatable protocol funcs
extension ChatSource {

    func appendMessage(text: String, chara: ChatChara) {
        _messages = _messageEditor.appendMessage(text: text, chara: chara).messages
        _onChanged(key: .messagesChanged)
    }

    func removeMessage(message: ChatMessage) {
        _messages = _messageEditor.removeMessage(message: message).messages
        _onChanged(key: .messagesChanged)
    }

    func editMessage(message: ChatMessage, text: String, chara: ChatChara) {
        _messages = _messageEditor.editMessage(message: message, text: text, chara: chara).messages
        _onChanged(key: .messagesChanged)
    }

    private var _messageEditor: ChatSourceMessagesEditor {
        get {
            return ChatSourceMessagesEditor(creator: _messageCreator, messages: _messages)
        }
    }
}
