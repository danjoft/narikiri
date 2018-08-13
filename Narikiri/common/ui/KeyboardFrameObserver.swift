import Foundation
import UIKit


// Usage:
//   let keyboardObserver = KeyboardFrameObserver()
//   keyboardObserver.delegate = self // self: KeyboardFrameObserverDelegate
class KeyboardFrameObserver {
    weak var delegate: KeyboardFrameObserverDelegate?
    var _lastHeight: CGFloat = 0

    init() {
        let notification = NotificationCenter.default
        let name = NSNotification.Name.self
        for eachTuple in [
            (name.UIKeyboardDidChangeFrame, #selector(KeyboardFrameObserver._didChangeFrame(_:))),
            (name.UIKeyboardWillShow, #selector(KeyboardFrameObserver._willShow(_:))),
            (name.UIKeyboardDidHide, #selector(KeyboardFrameObserver._didHide(_:)))
            ]
        {
            let name = eachTuple.0
            let selector = eachTuple.1
            notification.addObserver(self, selector: selector, name: name, object: nil)
        }
    }

    @objc func _didChangeFrame(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        delegate?.keyboardDidChangeFrame(frame: keyboardFrame)

        let newHeight = keyboardFrame.minY - UIScreen.main.bounds.maxY
        let heightDiff = newHeight - _lastHeight
        _lastHeight = newHeight
        delegate?.keyboardHeightDifferential(heightDifferential: heightDiff)

    }
    @objc func _willShow(_ notification: Notification) {
        _lastHeight = 0.0
        delegate?.keyboardWillShow()
    }
    @objc func _didHide(_ notification: Notification) {
        _lastHeight = 0.0
        delegate?.keyboardDidHide()
    }
}

// Delegate protocol for KeyboardFrameObserver.
// Should be class object
protocol KeyboardFrameObserverDelegate : class {
    func keyboardDidChangeFrame(frame: CGRect)
    func keyboardWillShow()
    func keyboardDidHide()
    func keyboardHeightDifferential(heightDifferential: CGFloat)
}
