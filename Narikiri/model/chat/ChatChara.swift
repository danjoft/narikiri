protocol ChatChara {
    var id: Int { get }
    var nickname: String { get }
}

internal class _ChatCharaImpl : ChatChara {
    var id: Int
    var nickname: String
    
    init(id: Int, nickname: String) {
        self.id = id
        self.nickname = nickname
    }
}
