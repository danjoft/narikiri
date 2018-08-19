protocol ChatSourceMessageUpdatable {
    func appendMessage(text: String, chara: ChatChara)
    func removeMessage(message: ChatMessage)
    func editMessage(message:ChatMessage, text: String, chara: ChatChara)
}
