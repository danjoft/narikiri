//

import XCTest
@testable import Narikiri

class TextFieldObservableTests: XCTestCase {

    private var _field: UITextField!
    private var _onChangedCount: Int = 0
    private var _observable: TextFieldObservable!
    
    override func setUp() {
        super.setUp()
        _field = UITextField()
        _onChangedCount = 0
        _observable = TextFieldObservableImpl(textField: _field)
        _observable.onChanged { [unowned self] in
            self._onChangedCount += 1
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testTextSet() {
        _field.text = "hello"
        XCTAssertTrue(_observable.isTextExists)
        XCTAssertEqual(_observable.text, "hello")

        _field.text = nil
        XCTAssertFalse(_observable.isTextExists)

        _field.text = ""
        XCTAssertFalse(_observable.isTextExists)

        XCTAssertEqual(_onChangedCount, 0)
    }

    func testSynchronizeEditingText() {
        _field.text = "aaaa"
        _observable.synchronizeEditingText()
        XCTAssertEqual("aaaa", _observable.text)
    }

}
