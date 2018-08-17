import XCTest
@testable import Narikiri

class MutableChatMessageTests: XCTestCase {

    var _message: MutableChatMessage!
    var _chara: ChatChara!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        _chara = _ChatCharaImpl(id: 99, nickname: "unkoman")
        _message = MutableChatMessageImpl(id: ChatModelSpecialIDs.notFixedId, order: 2, chara: _chara, text: "Hello Unko World.")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testInitialStates() {
        XCTAssertEqual(_message.id, ChatModelSpecialIDs.notFixedId)
        XCTAssertEqual(_message.order, 2)
        XCTAssertTrue(_message.chara === _chara)
        XCTAssertEqual(_message.text, "Hello Unko World.")

        XCTAssertFalse(_message.isIdFixed)
        XCTAssertTrue(_message.isDirty) // due to not fixed id
    }

    func testSetId() {
        _message.id = 3
        XCTAssertEqual(_message.id, 3)

        XCTAssertTrue(_message.isDirty)
        XCTAssertTrue(_message.isIdFixed)

        // default values
        XCTAssertEqual(_message.order, 2)
        XCTAssertTrue(_message.chara === _chara)
        XCTAssertEqual(_message.text, "Hello Unko World.")
    }

    func testSetOrder() {
        _message.order = 22
        XCTAssertEqual(_message.order, 22)
        XCTAssertTrue(_message.isDirty)

        // default values
        XCTAssertEqual(_message.id, ChatModelSpecialIDs.notFixedId)
        XCTAssertTrue(_message.chara === _chara)
        XCTAssertEqual(_message.text, "Hello Unko World.")
        XCTAssertFalse(_message.isIdFixed)
    }

    func testSetChara() {
        _chara = _ChatCharaImpl(id: 100, nickname: "unkoman")
        _message.chara = _chara
        XCTAssertTrue(_message.chara === _chara)
        XCTAssertEqual(_message.chara.id, 100)
        XCTAssertTrue(_message.isDirty)

        // default values
        XCTAssertEqual(_message.id, ChatModelSpecialIDs.notFixedId)
        XCTAssertEqual(_message.order, 2)
        XCTAssertEqual(_message.text, "Hello Unko World.")
        XCTAssertFalse(_message.isIdFixed)
    }

    func testSetText() {
        _message.text = "Unkokko\nUnkokko"
        XCTAssertEqual(_message.text, "Unkokko\nUnkokko")
        XCTAssertTrue(_message.isDirty)

        // default values
        XCTAssertEqual(_message.id, ChatModelSpecialIDs.notFixedId)
        XCTAssertEqual(_message.order, 2)
        XCTAssertTrue(_message.chara === _chara)
        XCTAssertFalse(_message.isIdFixed)
    }

    func testClearDirty() {
        _message.id = 44
        _message.clearDirty()
        XCTAssertFalse(_message.isDirty)
    }

}
