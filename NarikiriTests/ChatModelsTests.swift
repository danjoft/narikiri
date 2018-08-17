import XCTest
@testable import Narikiri

class ChatModelsTests: XCTestCase {

    var chara: ChatChara!
    var message: ChatMessage!
    var room: ChatRoom!

    var cellModel: ChatTableViewCellModel!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.chara = _ChatCharaImpl(id: 3, nickname: "unko")
        self.message = MutableChatMessageImpl(id: 5, order: 1, chara: self.chara, text: "unkokko")
        self.room = _ChatRoomImpl(id: 33, title: "pipipi")

        self.cellModel = _ChatTableViewCellModelImpl(message: message)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testChatCharaInitializer() {
        XCTAssertEqual(chara.id, 3)
        XCTAssertEqual(chara.nickname, "unko")
    }

    func testChatMessageInitializer() {
        XCTAssertEqual(message.id, 5)
        XCTAssertEqual(message.order, 1)
        XCTAssertEqual(message.chara.id, self.chara.id)
        XCTAssertEqual(message.text, "unkokko")
    }

    func testChatRoomInitializer() {
        XCTAssertEqual(room.id, 33)
        XCTAssertEqual(room.title, "pipipi")
    }

    func testChatTableViewCellModelInitializer() {
        XCTAssertEqual(cellModel.messageText, message.text)
        XCTAssertEqual(cellModel.charaNickname, chara.nickname)
    }

    func testChatMessageDirty() {
        XCTAssertTrue(message.isIdFixed)
        message = MutableChatMessageImpl(id: ChatModelSpecialIDs.notFixedId, order: 1, chara: self.chara, text: "unkokko")
        XCTAssertFalse(message.isIdFixed)
    }

}
