import XCTest
@testable import Narikiri

class ChatTableTests: XCTestCase {

    private var _chatFactory = DebugChatRoomFactory()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testChatTableViewCellSizeIdempotency() {

        let cell = ChatTableViewCell()
        cell.model = _makeCellModel(withMessageText: "a")

        XCTAssertNotEqual(_newCell(withMessageText: "a\na\na\na").frame, cell.frame)
        XCTAssertNotEqual(_newCell(withMessageText: "a\na").bounds, cell.bounds)

        let testEqualityOfNewAndOldCellBoundsWithSameContent = { (text: String) -> CGSize in
            let newedCell = self._newCell(withMessageText: text)
            cell.model = self._makeCellModel(withMessageText: text)
            XCTAssertEqual(cell.bounds, newedCell.bounds)
            XCTAssertEqual(cell.frame, newedCell.frame)
            return cell.bounds.size
        }

        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("a")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("a\na")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("a\na\na")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("a\na")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("a")

        let oneLineSize  = testEqualityOfNewAndOldCellBoundsWithSameContent("a")
        let theeLineSize = testEqualityOfNewAndOldCellBoundsWithSameContent("a\na\na")
        let twoLineSize  = testEqualityOfNewAndOldCellBoundsWithSameContent("a\na")
        XCTAssertTrue(oneLineSize.height < twoLineSize.height)
        XCTAssertTrue(twoLineSize.height < theeLineSize.height)

        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("ちなみにこの名はヒソカが子供の頃大好きだったチューインガムの商標名からとっている！")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("そろそろ狩るか…♠")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("動機の言語化か…\n余り好きじゃないしな。\nしかし案外…いや、やはりというべきか、自分を掴むカギはそこにあるか…")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("わざとけられてやったわけだが")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("もう遅いよ。\nもう知っちゃったんだから。\nオレもゴンも。")
        _ = testEqualityOfNewAndOldCellBoundsWithSameContent("念を使うと殺す\n声を出しても殺す")
    }

    private func _newCell(withMessageText text: String) -> ChatTableViewCell {
        let cell = ChatTableViewCell()
        cell.model = _makeCellModel(withMessageText: text)
        return cell
    }

    private func _makeCellModel(withMessageText text: String) -> ChatTableViewCellModel {
        let message = _chatFactory.message(withText: text)
        return _ChatTableViewCellModelImpl(message: message)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
