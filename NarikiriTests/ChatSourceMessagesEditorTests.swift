//

import XCTest
@testable import Narikiri

class ChatSourceMessagesEditorTests: XCTestCase {

    private var _originMessages: [MutableChatMessage]!
    private var _charas: [ChatChara]!
    private var _editor: ChatSourceMessagesEditor!
    private var _messageCreator: __ChatMessageCreatorForTest!
    
    override func setUp() {
        super.setUp()
        _charas = [
            _ChatCharaImpl(id: 111, nickname: "hi"),
            _ChatCharaImpl(id: 222, nickname: "ho"),
        ]
        _originMessages = [
            MutableChatMessageImpl(id: 11, order: 1, chara: _charas[0], text: "hello"),
            MutableChatMessageImpl(id: 12, order: 2, chara: _charas[1], text: "world"),
            MutableChatMessageImpl(id: 13, order: 3, chara: _charas[0], text: "beautiful"),
            MutableChatMessageImpl(id: 14, order: 4, chara: _charas[1], text: "world!"),
        ]
        _messageCreator = __ChatMessageCreatorForTest()
        _editor = ChatSourceMessagesEditor(creator: _messageCreator, messages: _originMessages)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialStates() {
        __assertOriginMessages()
        __assertOrders()
        __assertCreatorCalledCount(0)
    }

    func testAppendAndRemove() {
        // append
        _ = _editor.appendMessage(text: "new hero", chara: _charas[0])
        __assertOriginMessages()
        __assertOrders()
        __assertCreatorCalledCount(1)
        __assertMessagesCount(diff: +1)
        XCTAssertEqual(_editor.messages.last?.text, "new hero")
        XCTAssertTrue(_editor.messages.last?.chara === _charas[0])
        XCTAssertFalse(_editor.messages.last!.isIdFixed)
        let firstAppendedMessage = _editor.messages.last

        // append
        _ = _editor.appendMessage(text: "super hero", chara: _charas[1])
        __assertOriginMessages()
        __assertOrders()
        __assertCreatorCalledCount(2)
        __assertMessagesCount(diff: +2)
        XCTAssertEqual(_editor.messages.last?.text, "super hero")
        XCTAssertTrue(_editor.messages.last?.chara === _charas[1])
        XCTAssertFalse(_editor.messages.last!.isIdFixed)

        // remove
        _ = _editor.removeMessage(message: firstAppendedMessage!)
        __assertOriginMessages()
        __assertOrders()
        __assertCreatorCalledCount(2)
        __assertMessagesCount(diff: +1)
    }

    func testRemove() {
        let removingMessage = _originMessages.first!
        _ = _editor.removeMessage(message: removingMessage)
        __assertOrders()
        __assertCreatorCalledCount(0)
        __assertMessagesCount(diff: -1)
        XCTAssertTrue(_originMessages[1] === _editor.messages[0])
        XCTAssertTrue(_originMessages[2] === _editor.messages[1])
        XCTAssertTrue(_originMessages[3] === _editor.messages[2])
    }

    func testEditText() {
        let editingMessage = _editor.messages[1]
        _ = _editor.editMessage(message: editingMessage, text: "pappi", chara: editingMessage.chara)
        __assertOrders()
        __assertCreatorCalledCount(0)
        __assertMessagesCount(diff: 0)
        XCTAssertEqual(editingMessage.text, "pappi")
        XCTAssertTrue(editingMessage.chara === _charas[1])

        XCTAssertEqual(_editor.messages[0].text, "hello")
        XCTAssertEqual(_editor.messages[2].text, "beautiful")
        XCTAssertEqual(_editor.messages[3].text, "world!")
    }

    func testEditChara() {
        let editingMessage = _editor.messages[1]
        XCTAssertTrue(editingMessage.chara === _charas[1])
        _ = _editor.editMessage(message: editingMessage, text: editingMessage.text, chara: _charas[0])
        __assertOrders()
        __assertCreatorCalledCount(0)
        __assertMessagesCount(diff: 0)
        XCTAssertTrue(editingMessage.chara === _charas[0])
    }
    

    private func __assertOriginMessages() {
        for (index, originMessage) in _originMessages.enumerated() {
            XCTAssertTrue(originMessage === _editor.messages[index])
        }
    }

    private func __assertOrders() {
        let messageFirstOrder = 1
        for (index, message) in _editor.messages.enumerated() {
            XCTAssertEqual(message.order, index + messageFirstOrder)
        }
    }

    private func __assertCreatorCalledCount(_ count: Int) {
        XCTAssertEqual(_messageCreator.createCalledCount, count)
    }

    private func __assertMessagesCount(diff: Int) {
        XCTAssertEqual(_editor.messages.count, _originMessages.count + diff)
    }
}

fileprivate class __ChatMessageCreatorForTest: ChatMessageCreator {

    var createCalledCount = 0

    override func createUnfixedMessage(text: String, chara: ChatChara, order: Int) -> MutableChatMessage {
        createCalledCount += 1
        return super.createUnfixedMessage(text: text, chara: chara, order: order)
    }

}

