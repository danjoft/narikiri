import XCTest
@testable import Narikiri

class CommonUIViewTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFrameOriginAssigning() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let view = _CommonUIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.frame(origin: CGPoint(x: 10, y: 10))

        XCTAssertEqual(view.frame, CGRect(x: 10, y: 10, width: 100, height: 100))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

fileprivate class _CommonUIView: UIView, CommonUIView {
}

