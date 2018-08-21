import UIKit

// Usage:
//  _observable = TextFieldObservableImpl(textField: _inputField)
//  _observable.onChanged { [unowned self] in
//      self._updateView()
//  }
protocol TextFieldObservable {
    func onChanged(_ callback: @escaping () -> Void)
    var isTextExists: Bool { get }
    var text: String { get }
    func synchronizeEditingText()
}

class TextFieldObservableImpl : NSObject, TextFieldObservable {
    private var _textField: UITextField
    private var _editingText: String?
    private var _onChanged: (() -> Void)?

    init(textField: UITextField) {
        assert(textField.delegate == nil, "Already delegate set.")

        _textField = textField
        super.init()

        _textField.delegate = self
    }

    func onChanged(_ callback: @escaping () -> Void) {
        _onChanged = callback
    }

    var isTextExists: Bool {
        get {
            return (_editingText ?? _textField.text ?? "").count > 0
        }
    }
    var text: String {
        get {
            assert(isTextExists, "Not exists text. Check isTextEdists befor get text.")
            return _editingText ?? _textField.text ?? ""
        }
    }

    func synchronizeEditingText() {
        if _editingText != nil {
            _editingText = _textField.text
        }
    }

}

extension TextFieldObservableImpl : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        _editingText = _textField.text
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        _editingText = (_editingText! as NSString).replacingCharacters(in: range, with: string)
        self._onChanged?()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        _editingText = nil
        self._onChanged?()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }

}
