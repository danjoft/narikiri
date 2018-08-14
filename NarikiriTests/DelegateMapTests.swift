import XCTest
@testable import Narikiri

class DelegateMapTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDelegateCall() {
        let delegateMap = DelegateMap<_EventType, _DelegateProtocol>()
        let delegate = _Delegate()
        delegateMap.addDelegate(key: .changed, delegate: delegate)
        XCTAssertEqual(delegate.calledCount, 0)
        delegateMap.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 1)

        delegateMap.forEachDelegate(key: .screamed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 1)

        delegateMap.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 2)
    }

    func testMultipleDelegateCall() {
        let delegateMap = DelegateMap<_EventType, _DelegateProtocol>()
        let delegate1 = _Delegate()
        let delegate2 = _Delegate()

        delegateMap.addDelegate(key: .changed, delegate: delegate1)
        delegateMap.addDelegate(key: .changed, delegate: delegate2)

        delegateMap.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate1.calledCount, 1)
        XCTAssertEqual(delegate2.calledCount, 1)

        delegateMap.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate1.calledCount, 2)
        XCTAssertEqual(delegate2.calledCount, 2)

        delegateMap.removeDelegate(key: .changed, delegate: delegate2)
        delegateMap.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate1.calledCount, 3)
        XCTAssertEqual(delegate2.calledCount, 2)
    }

    func testDifferentTypeCall() {
        let delegate1 = _Delegate()
        let delegate2 = _Delegate()
        let map = DelegateMap<_EventType, _DelegateProtocol>()
        map.addDelegate(key: .changed, delegate: delegate1)
        map.addDelegate(key: .screamed, delegate: delegate2)

        map.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate1.calledCount, 1)
        XCTAssertEqual(delegate2.calledCount, 0)

        map.forEachDelegate(key: .screamed) { $0.onChanged() }
        map.forEachDelegate(key: .screamed) { $0.onChanged() }
        XCTAssertEqual(delegate1.calledCount, 1)
        XCTAssertEqual(delegate2.calledCount, 2)

        map.removeDelegate(key: .screamed, delegate: delegate1)
        map.removeDelegate(key: .screamed, delegate: delegate2)
        map.forEachDelegate(key: .screamed) { $0.onChanged() }
        map.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate1.calledCount, 2)
        XCTAssertEqual(delegate2.calledCount, 2)
    }

    func testRemoveDelegate() {
        let delegate = _Delegate()
        let map = DelegateMap<_EventType, _DelegateProtocol>()
        map.addDelegate(key: .changed, delegate: delegate)
        map.addDelegate(key: .screamed, delegate: delegate)

        map.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 1)

        map.removeDelegate(key: .changed, delegate: delegate)
        map.forEachDelegate(key: .changed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 1)
        map.forEachDelegate(key: .screamed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 2)

        map.removeDelegate(key: .screamed, delegate: delegate)
        map.forEachDelegate(key: .changed) { $0.onChanged() }
        map.forEachDelegate(key: .screamed) { $0.onChanged() }
        XCTAssertEqual(delegate.calledCount, 2)
    }

    func testCountAfterGabageCollection() {
        var delegate1: _Delegate? = _Delegate()
        var delegate2: _Delegate? = _Delegate()
        let map = DelegateMap<_EventType, _DelegateProtocol>()

        map.addDelegate(key: .changed, delegate: delegate1!)
        map.addDelegate(key: .screamed, delegate: delegate1!)
        map.addDelegate(key: .screamed, delegate: delegate2!)

        XCTAssertEqual(map.count(of: .changed), 1)
        XCTAssertEqual(map.count(of: .screamed), 2)

        delegate1 = nil

        XCTAssertEqual(map.count(of: .changed), 0)
        XCTAssertEqual(map.count(of: .screamed), 1)

        delegate2 = nil

        XCTAssertEqual(map.count(of: .changed), 0)
        XCTAssertEqual(map.count(of: .screamed), 0)
    }
}

fileprivate protocol _DelegateProtocol : class {
    func onChanged()
}
fileprivate class _Delegate : _DelegateProtocol {
    var calledCount = 0
    func onChanged() {
        calledCount += 1
    }
}
fileprivate enum _EventType {
    case changed
    case screamed
}
