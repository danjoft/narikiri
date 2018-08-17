
class ChatSourceMessagesEditor {
    private var _creator: ChatMessageCreatable
    private var _messages: [MutableChatMessage]

    var messages: [MutableChatMessage] {
        get {
            return _messages
        }
    }

    init(creator: ChatMessageCreatable, messages: [MutableChatMessage]) {
        self._creator = creator
        self._messages = messages
    }

    func appendMessage(text:String, chara: ChatChara) -> Self {
        let nextOrder = _getNextOrder()
        let message = self._creator.createUnfixedMessage(text: text, chara: chara, order: nextOrder)
        message.id = ChatModelSpecialIDs.notFixedId
        _messages.append(message)
        return self
    }

    func removeMessage(message: ChatMessage) -> Self {
        guard let targetIndex = _getMessageIndex(withSameOrder: message) else {
            return self
        }
        _messages.remove(at: targetIndex)
        _alignOrder()
        return self
    }

    func editMessage(message: ChatMessage, text: String, chara: ChatChara) -> Self {
        guard let targetIndex = _getMessageIndex(withSameOrder: message) else {
            return self
        }
        let targetMessage = _messages[targetIndex]
        targetMessage.text = text
        targetMessage.chara = chara
        return self
    }

    private func _getMessageIndex(withSameOrder message: ChatMessage) -> Int? {
        return _messages.index(where: {$0.order == message.order})
    }

    private func _alignOrder() {
        for (index, message) in _messages.enumerated() {
            let order = index + ChatModelSpecialIDs.initialMessageOrder
            message.order = order
        }
    }

    private func _getNextOrder() -> Int {
        guard let lastMessage = _messages.last else {
            return ChatModelSpecialIDs.initialMessageOrder
        }
        return lastMessage.order + 1
    }
}

