import XCTest
@testable import Narikiri

class ChatInputBarViewModelTests: XCTestCase {

    private var _chatSource: ChatInputBarViewModel.ChatSourcePt!
    private var _model: ChatInputBarViewModel!
    private var _delegate: _Delegate!

    override func setUp() {
        super.setUp()

        _chatSource = DebugChatRoomFactory().chatSource(numCharas: 2, numMessages: 2)

        _delegate = _Delegate()

        _model = ChatInputBarViewModel(chatSource: _chatSource)
        _model.delegate = _delegate
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitialState() {
        XCTAssertEqual(_model.charas.count, 2)
        XCTAssertTrue(_model.charas[0] === _chatSource.charas[0])
        XCTAssertTrue(_model.charas[1] === _chatSource.charas[1])
        XCTAssertTrue(_model.selectedChara === _model.charas[0])
        XCTAssertTrue(_model.isEnableInput)
        XCTAssertTrue(_model.isSendable(text: "hi"))
        XCTAssertFalse(_model.isSendable(text: ""))
    }

    func testNoCharasState() {
        let room = _ChatRoomImpl(id: 1, title: "hello room")
        _chatSource = ChatSource(room: room, charas: [], messages: [], messageCreator: ChatMessageCreator())
        _model = ChatInputBarViewModel(chatSource: _chatSource)

        XCTAssertEqual(_model.charas.count, 0)
        XCTAssertNil(_model.selectedChara)
        XCTAssertFalse(_model.isEnableInput)
        XCTAssertFalse(_model.isSendable(text: "hi"))
        XCTAssertFalse(_model.isSendable(text: ""))
    }

    func testSendText() {
        let sendResponse = _model.sendText(text: "hello world")
        XCTAssertEqual(_chatSource.messages.count, 3)
        XCTAssertTrue(_chatSource.messages.last?.chara === _model.selectedChara)
        XCTAssertEqual(_chatSource.messages.last?.text, "hello world")
        XCTAssertEqual(_chatSource.messages.last?.order, 3)

        XCTAssertEqual(sendResponse.endEditing, false)
        XCTAssertEqual(sendResponse.flushText, true)
    }

    func testCharaSelectedChangedDelegation() {
        XCTAssertEqual(_delegate.calledNames, [])

        _model.selectedChara = _model.charas[1]
        XCTAssertTrue(_model.selectedChara === _model.charas[1])
        XCTAssertEqual(_delegate.calledNames, ["select"])

        _model.selectedChara = _model.charas[0]
        XCTAssertTrue(_model.selectedChara === _model.charas[0])
        XCTAssertEqual(_delegate.calledNames, ["select", "select"])
    }

    func testChatasUpdatedDelegation() {
        // TODO: implement
        XCTAssertTrue(true)
    }
    
}

fileprivate class _Delegate : ChatInputBarInputModelDelegate {
    var calledNames = [String]()

    func onSelectedCharaChanged() {
        calledNames.append("select")
    }
    func onCharasUpdated() {
        calledNames.append("update")
    }
}
