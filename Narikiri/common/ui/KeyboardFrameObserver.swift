import Foundation
import UIKit


// Usage:
//   let keyboardObserver = KeyboardFrameObserver()
//   keyboardObserver.delegate = self // self: KeyboardFrameObserverDelegate
class KeyboardFrameObserver {
    weak var delegate: KeyboardFrameObserverDelegate?

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
    }
    @objc func _willShow(_ notification: Notification) {
        delegate?.keyboardWillShow()
    }
    @objc func _didHide(_ notification: Notification) {
        delegate?.keyboardDidHide()
    }
}

// Delegate protocol for KeyboardFrameObserver.
// Should be class object
protocol KeyboardFrameObserverDelegate : class {
    func keyboardDidChangeFrame(frame: CGRect)
    func keyboardWillShow()
    func keyboardDidHide()
}
