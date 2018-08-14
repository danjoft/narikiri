import XCTest
@testable import Narikiri

class WeakContainerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWeak() {
        var obj = UIView()
        let weakWrapper = Weak<UIView>(obj)
        XCTAssertEqual(obj, weakWrapper.get)
        XCTAssertFalse(weakWrapper.isNone)
        obj = UIView()
        XCTAssertNil(weakWrapper.get)
        XCTAssertTrue(weakWrapper.isNone)
    }

    func testWeakContainer() {
        var obj1 = UIView()
        var obj2 = UIView()

        let container = WeakContainer<UIView>()
        container.append(obj1)
        container.append(obj2)
        XCTAssertEqual(container.list.count, 2)
        XCTAssertEqual(container.list[0].get, obj1)
        XCTAssertEqual(container.list[1].get, obj2)

        obj2 = UIView()
        XCTAssertEqual(container.list.count, 2)
        let removedCount = container.cleanUp()
        XCTAssertEqual(removedCount, 1)
        XCTAssertEqual(container.list.count, 1)
        XCTAssertEqual(container.list[0].get, obj1)

        obj1 = UIView()
        var obj3 = UIView()
        container.append(obj3)
        XCTAssertEqual(container.list.count, 1)
        XCTAssertEqual(obj3, container.list[0].get)

        obj3 = UIView()
        XCTAssertTrue(container.list[0].isNone)
        _ = container.cleanUp()
        XCTAssertEqual(container.list.count, 0)
    }

    func testWeakContainer2() {
        var objRaw = UIView()
        weak var obj = objRaw
        var container = WeakContainer<UIView>()
        container.append(obj!)
        XCTAssertEqual(obj, container.list[0].get)

        container = WeakContainer<UIView>()
        objRaw = UIView()
        XCTAssertNil(obj)
    }
}
