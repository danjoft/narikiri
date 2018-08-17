// This is for new ChatMessage.
// If you want construct the already exist-fixed message like via api data,
// you should create it via any other way like directly initializer.
protocol ChatMessageCreatable {
    func createUnfixedMessage(text: String, chara: ChatChara, order: Int) -> MutableChatMessage
}

class ChatMessageCreator: ChatMessageCreatable {

    func createUnfixedMessage(text: String, chara: ChatChara, order: Int) -> MutableChatMessage {
        return MutableChatMessageImpl(id: ChatModelSpecialIDs.notFixedId, order: order, chara: chara, text: text)
    }

}
