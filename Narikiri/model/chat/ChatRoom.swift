protocol ChatRoom {
    var id: Int { get }
    var title: String { get }
}

internal class _ChatRoomImpl : ChatRoom {
    var id: Int
    var title: String
    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}
