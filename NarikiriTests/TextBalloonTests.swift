import XCTest
@testable import Narikiri

class TextBalloonTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSizeAfterTextReset() {
        let balloon: TextBalloon = TextBalloon(text: "")

        balloon.text = "a"
        let sizeOfOneLine = balloon.bounds

        balloon.text = "a\na\na"
        let sizeOfThreeLines = balloon.bounds

        balloon.text = "a\na"
        let sizeOfTwoLines = balloon.bounds

        XCTAssertTrue(sizeOfOneLine.height < sizeOfTwoLines.height)
        XCTAssertTrue(sizeOfTwoLines.height < sizeOfThreeLines.height)
        XCTAssertEqual(sizeOfOneLine.width, sizeOfTwoLines.width)
        XCTAssertEqual(sizeOfTwoLines.width, sizeOfThreeLines.width)
    }

}
