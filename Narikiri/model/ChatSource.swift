//protocol ChatSourceChangedDelegate {
//    func onChatSourceChanged()
//}
//
//class ChatSource {
//
//    var _delegatesMap = DelegatesMap<ChatSource.EventType, ChatSourceChangedDelegate>()
//
//    func addDelegate(type: ChatSource.EventType, delegate: ChatSourceChangedDelegate) {
//        _delegatesMap.addDelegate(key: type, delegate: delegate)
//    }
//
//    func removeDelegate(type: ChatSource.EventType, delegate: ChatSourceChangedDelegate) {
//        _delegatesMap.removeDelegate(key: type, delegate: delegate)
//    }
//
//
//    class DelegatesMap<Key : Hashable, T> {
//        private var _map: [Key : Delegates<T>] = [:]
//
//        func addDelegate(key: Key, delegate: T) -> Void {
//            _getDelegates(key).array.append(delegate)
//        }
//
//        func removeDelegate(key: Key, delegate: T) -> Void {
//            _getDelegates(key).removeIfExist(delegate: delegate)
//        }
//
//        private func _getDelegates(_ key: Key) -> Delegates<T> {
//            if _map[key] == nil {
//                _map[key] = Delegates<T>()
//            }
//            return _map[key]!
//        }
//    }
//
//    class Delegates<T> {
//        var array: [T] = []
//        func removeIfExist(delegate: T) {
//            array = array.filter() { (inArrayDelegate: T) -> Bool in
//                return inArrayDelegate !== delegate
//            }
//        }
//    }
//}
//
//extension ChatSource {
//
//    enum EventType: String {
//        case chatChanged
//        case roomChanged
//        case charasChanged
//        case messagesChanged
//    }
//}
//
