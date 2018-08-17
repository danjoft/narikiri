//

import XCTest
@testable import Narikiri

class ChatMessageCreatableTests: XCTestCase {

    var _chara: ChatChara!
    var _creator: ChatMessageCreatable!

    override func setUp() {
        super.setUp()
        _chara = _ChatCharaImpl(id: 3, nickname: "unkoman")
        _creator = ChatMessageCreator()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCreate() {
        let message = _creator.createUnfixedMessage(text: "fallow", chara: _chara, order: 3)
        XCTAssertEqual(message.text, "fallow")
        XCTAssertEqual(message.order, 3)
        XCTAssertTrue(message.chara === _chara)

        XCTAssertFalse(message.isIdFixed)
        XCTAssertTrue(message.isDirty) // due to id not fixed.
    }

}
