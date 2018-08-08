protocol ChatMessage {
    var id: Int { get }
    var order: Int { get }
    var chara: ChatChara { get }
    var text: String { get }
}

internal class _ChatMessageImpl : ChatMessage {
    var id: Int
    var order: Int
    var chara: ChatChara
    var text: String

    init(id: Int, order: Int, chara: ChatChara, text: String) {
        self.id = id
        self.order = order
        self.chara = chara
        self.text = text
    }
}
