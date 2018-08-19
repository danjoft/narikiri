protocol ChatSourceGettable {
    var room: ChatRoom { get }
    var charas: [ChatChara] { get }
    var messages: [ChatMessage] { get }
}
