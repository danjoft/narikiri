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

    func testMaxWidthSet() {
        let balloon = TextBalloon(text: "あああああああああああああああああああああああああああああああああああああああああああああああああああああ")

        func isWidthAround(_ maxWidth: CGFloat) -> Bool {
            let buffWidth: CGFloat = 40
            return balloon.frame.width <= maxWidth &&
                maxWidth - buffWidth < balloon.frame.width
        }

        balloon.maxWidth = 200
        XCTAssertTrue( isWidthAround(200) )
        balloon.maxWidth = 100
        XCTAssertTrue( isWidthAround(100) )
        balloon.maxWidth = 150
        XCTAssertTrue( isWidthAround(150) )
        balloon.maxWidth = 300
        XCTAssertTrue( isWidthAround(300) )
        XCTAssertFalse( isWidthAround(250) )
        XCTAssertFalse( isWidthAround(200) )
        XCTAssertFalse( isWidthAround(100) )
    }

}
