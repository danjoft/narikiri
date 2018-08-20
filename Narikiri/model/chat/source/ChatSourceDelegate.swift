protocol ChatSourceDelegate {
    func onChatSourceChanged(eventType: ChatSourceEventType)
}

enum ChatSourceEventType: String {
    case roomChanged
    case charasChanged
    case messagesChanged

    // will be called after the all events above
    case changed
}

protocol ChatSourceDelegateRegisterable {
    func addDelegate(key: ChatSourceEventType, delegate: ChatSourceDelegate)
    func removeDelegate(key: ChatSourceEventType, delegate: ChatSourceDelegate)
}

