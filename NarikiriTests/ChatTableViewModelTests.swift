import XCTest
@testable import Narikiri

class ChatTableViewModelTests: XCTestCase {

    private var _chatSource: ChatSource!
    private var _model: ChatTableViewModel!
    private var _delegate: _Delegate!
    
    override func setUp() {
        super.setUp()
        _chatSource = DebugChatRoomFactory().chatSource(numCharas: 2, numMessages: 3)
        _delegate = _Delegate()
        _model = ChatTableViewModelImpl(chatSource: _chatSource)
        _model.delegate = _delegate
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(_model.cellModels.count, 3)
        for (index, cellModel) in _model.cellModels.enumerated() {
            let message : ChatMessage = _chatSource.messages[index]
            XCTAssertEqual(cellModel.chatMessageId, message.id)
            XCTAssertEqual(cellModel.messageText, message.text)
            XCTAssertEqual(cellModel.charaNickname, message.chara.nickname)
            let viewSize = _model.getCachedCellSize(at: index)
            XCTAssertTrue(viewSize.width > 0)
            XCTAssertTrue(viewSize.height > 0)
        }
        XCTAssertEqual(_delegate.updatedCalledCount, 0)
    }

    func testMessageChange() {
        XCTAssertEqual(_delegate.updatedCalledCount, 0)

        _chatSource.appendMessage(text: "hehehe,ChatTableViewModelTests", chara: _chatSource.charas[0])
        XCTAssertEqual(_delegate.updatedCalledCount, 1)
        XCTAssertEqual(_model.cellModels.count, 4)
        XCTAssertEqual(_model.cellModels.last?.messageText, "hehehe,ChatTableViewModelTests")

        _chatSource.removeMessage(message: _chatSource.messages[1])
        XCTAssertEqual(_delegate.updatedCalledCount, 2)
        XCTAssertEqual(_model.cellModels.count, 3)
        XCTAssertEqual(_model.cellModels.last?.messageText, "hehehe,ChatTableViewModelTests")
    }

    func testNullObject() {
        _model = NopChatTableViewModelImpl()
        XCTAssertEqual(_model.cellModels.count, 0)
    }

}

fileprivate class _Delegate : ChatTableViewModelDelegate {
    var updatedCalledCount = 0
    func onChatTableViewModelUpdated() {
        updatedCalledCount += 1
    }
}
