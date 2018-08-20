//

import XCTest
@testable import Narikiri

class ChatSourceTests: XCTestCase {

    var _chatSource: ChatSourceControlable!
    var _gettable: ChatSourceGettable { get { return _chatSource } }
    var _messageUpdatable: ChatSourceMessageUpdatable { get { return _chatSource } }
    var _delegateRegisterable: ChatSourceDelegateRegisterable { get { return _chatSource } }

    fileprivate var _delegate: _ChatSourceDelegate!

    override func setUp() {
        super.setUp()
        let room = _ChatRoomImpl(id: 1, title: "hello room")
        let charas = [_ChatCharaImpl(id: 88, nickname: "hello man"),
                      _ChatCharaImpl(id: 99, nickname: "why man")]
        let messages = [
            MutableChatMessageImpl(id: 111, order: 1, chara: charas[1], text: "hello1"),
            MutableChatMessageImpl(id: 222, order: 2, chara: charas[0], text: "hello2"),
        ]
        _chatSource = ChatSource(room: room, charas: charas, messages: messages, messageCreator: ChatMessageCreator())
        _delegate = _ChatSourceDelegate()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInitialProps() {
        // charas
        XCTAssertEqual(_gettable.charas.count, 2)
        XCTAssertEqual(_gettable.charas[0].id, 88)
        XCTAssertEqual(_gettable.charas[1].id, 99)
        XCTAssertEqual(_gettable.charas[1].nickname, "why man")
        // messages
        XCTAssertEqual(_gettable.messages.count, 2)
        XCTAssertEqual(_gettable.messages[0].id, 111)
        XCTAssertEqual(_gettable.messages[1].id, 222)
        XCTAssertTrue(_gettable.messages[0].chara === _gettable.charas[1])
        XCTAssertEqual(_gettable.messages[1].text, "hello2")
        // room
        XCTAssertEqual(_gettable.room.id, 1)
        XCTAssertEqual(_gettable.room.title, "hello room")
    }
    
    func testMessagesChanging() {
        _messageUpdatable.appendMessage(text: "unko", chara: _gettable.charas[1])
        XCTAssertEqual(_gettable.messages.count, 3)
        XCTAssertEqual(_gettable.messages[2].text, "unko")
        XCTAssertTrue(_gettable.messages[2].chara === _gettable.charas[1])

        _messageUpdatable.removeMessage(message: _gettable.messages[1])
        XCTAssertEqual(_gettable.messages.count, 2)
        XCTAssertEqual(_gettable.messages[0].id, 111)
        XCTAssertEqual(_gettable.messages[1].text, "unko")
        XCTAssertEqual(_gettable.messages[1].order, 2)

        _messageUpdatable.editMessage(message: _gettable.messages[1], text: "unko2", chara: _gettable.charas[1])
        XCTAssertEqual(_gettable.messages[1].text, "unko2")
        XCTAssertEqual(_gettable.messages[0].text, "hello1")
    }

    func testChangeMessageChangeDelegateRespectively() {
        _delegateRegisterable.addDelegate(key: .messagesChanged, delegate: _delegate)
        XCTAssertEqual(_delegate.calledTypes, [])

        _messageUpdatable.appendMessage(text: "unko", chara: _gettable.charas[1])
        XCTAssertEqual(_delegate.calledTypes, [.messagesChanged])

        _messageUpdatable.removeMessage(message: _gettable.messages[1])
        XCTAssertEqual(_delegate.calledTypes, [.messagesChanged, .messagesChanged])

        _messageUpdatable.editMessage(message: _gettable.messages[0], text: "a", chara: _gettable.charas[0])
        XCTAssertEqual(_delegate.calledTypes, [.messagesChanged, .messagesChanged, .messagesChanged])

        _delegateRegisterable.removeDelegate(key: .messagesChanged, delegate: _delegate)
        _messageUpdatable.appendMessage(text: "unko", chara: _gettable.charas[1])
        _messageUpdatable.removeMessage(message: _gettable.messages[0])
        _messageUpdatable.editMessage(message: _gettable.messages[0], text: "a", chara: _gettable.charas[0])
        XCTAssertEqual(_delegate.calledTypes, [.messagesChanged, .messagesChanged, .messagesChanged])
    }

    func testAllChangeDelegate() {
        _delegateRegisterable.addDelegate(key: .messagesChanged, delegate: _delegate)
        _delegateRegisterable.addDelegate(key: .changed, delegate: _delegate)

        _messageUpdatable.appendMessage(text: "unko", chara: _gettable.charas[1])
        _messageUpdatable.removeMessage(message: _gettable.messages[1])
        _messageUpdatable.editMessage(message: _gettable.messages[0], text: "a", chara: _gettable.charas[0])
        XCTAssertEqual(_delegate.calledTypes, [.messagesChanged, .changed, .messagesChanged, .changed, .messagesChanged, .changed])

        _delegate.clear()
        _delegateRegisterable.removeDelegate(key: .changed, delegate: _delegate)
        _messageUpdatable.appendMessage(text: "unko", chara: _gettable.charas[1])
        _messageUpdatable.removeMessage(message: _gettable.messages[1])
        _messageUpdatable.editMessage(message: _gettable.messages[0], text: "a", chara: _gettable.charas[0])
        XCTAssertEqual(_delegate.calledTypes, [.messagesChanged, .messagesChanged, .messagesChanged])
    }

}

fileprivate class _ChatSourceDelegate: ChatSourceDelegate {
    var calledTypes: [ChatSourceEventType] = []

    func onChatSourceChanged(eventType: ChatSourceEventType) {
        calledTypes.append(eventType)
    }
    func clear() {
        calledTypes = []
    }
}
