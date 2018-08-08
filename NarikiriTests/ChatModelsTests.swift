import XCTest
@testable import Narikiri

class ChatModelsTests: XCTestCase {

    var chara: ChatChara!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.chara = _ChatCharaImpl(id: 3, nickname: "unko")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChatCharaInitializer() {
        let chara: ChatChara = self.chara
        XCTAssertEqual(chara.id, 3)
        XCTAssertEqual(chara.nickname, "unko")
    }

    func testChatMessageInitializer() {
        let message: ChatMessage = _ChatMessageImpl(id: 5, order: 1, chara: self.chara, text: "unkokko")
        XCTAssertEqual(message.id, 5)
        XCTAssertEqual(message.order, 1)
        XCTAssertEqual(message.chara.id, self.chara.id)
        XCTAssertEqual(message.text, "unkokko")
    }

    func testChatRoomInitializer() {
        let room = _ChatRoomImpl(id: 33, title: "pipipi")
        XCTAssertEqual(room.id, 33)
        XCTAssertEqual(room.title, "pipipi")
    }

}
