//

import XCTest

class BalloonContainerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testContainerSize() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let contentFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let content = UIView(frame: contentFrame)
        let balloonContainer = BalloonContainer(content: content)
        let margin = BalloonContainer.margin
        XCTAssertEqual(
            balloonContainer.frame,
            CGRect(
                origin: CGPoint(x: 0, y: 0), // not same as content frame because this always must be zero.
                size: CGSize(
                    width: contentFrame.size.width + margin * 2,
                    height: contentFrame.size.height + margin * 2
                )
            )
        )
    }

    func testContainerSizeTheContentOfWhichOriginIsNonZero() {
        let contentFrame = CGRect(x: 99, y: 99, width: 100, height: 100)
        let content = UIView(frame: contentFrame)
        let balloonContainer = BalloonContainer(content: content)
        let margin = BalloonContainer.margin
        XCTAssertEqual(
            balloonContainer.frame,
            CGRect(
                origin: CGPoint(x: 0, y: 0),
                size: CGSize(
                    width: contentFrame.size.width + margin * 2,
                    height: contentFrame.size.height + margin * 2
                )
            )
        )
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
