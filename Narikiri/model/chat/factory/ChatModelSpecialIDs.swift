class ChatModelSpecialIDs {
    static let notFixedId: Int = -1
    static let initialMessageOrder: Int = 1

    static func isFixedId(id: Int) -> Bool {
        return id != notFixedId
    }
}
