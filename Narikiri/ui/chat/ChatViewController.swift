//

import UIKit

class ChatViewController: UIViewController {

    var _tableViewController: ChatTableViewController!
    var _inputViewController: ChatInputViewController!

    private var _keyboardObserver: KeyboardFrameObserver!
    private var _keyboardOverlapY: CGFloat = 0

    var chatSource: ChatSourceControlable? {
        didSet {
            _onChatSourceUpdated()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _tableViewController = ChatTableViewController()
        addChildViewController(_tableViewController)
        view.addSubview(_tableViewController.view)
        _tableViewController.didMove(toParentViewController: self)

        _inputViewController = ChatInputViewController()
        addChildViewController(_inputViewController)
        view.addSubview(_inputViewController.view)
        _inputViewController.didMove(toParentViewController: self)

        _keyboardObserver = KeyboardFrameObserver()
        _keyboardObserver.delegate = self

        _tableViewController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func _finishEditing() {
        view.endEditing(true)
    }

    func _onChatSourceUpdated() {
        guard let chatSource = chatSource else {
            return
        }
        _tableViewController.setChatSource(chatSource: chatSource)
        _inputViewController.setChatSource(chatSource: chatSource)
        view.setNeedsDisplay()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let tableLayerHeight = view.frame.height - _inputViewController.barHeight - _keyboardOverlapY
        let tableFrame = CGRect(
            origin: view.frame.origin,
            size: CGSize(
                width: view.frame.width, height: tableLayerHeight)
        )
        _tableViewController.view.frame = tableFrame
        _inputViewController.view.frame = CGRect(
            origin: view.frame.offsetBy(dx: 0, dy: tableFrame.maxY).origin,
            size: CGSize(width: view.frame.width, height: _inputViewController.barHeight))

        _tableViewController.view.frame = tableFrame
    }

}

extension ChatViewController : KeyboardFrameObserverDelegate {

    func keyboardDidChangeFrame(frame: CGRect) {
        let keyboardFrame = view.convert(frame, from: view)
        _keyboardOverlapY = view.frame.maxY - keyboardFrame.minY
        view.setNeedsLayout() // needed for viewDidLayoutSubviews() to be called
    }

    func keyboardWillShow() {
        _keyboardOverlapY = 0.0
    }

    func keyboardDidHide() {
        _keyboardOverlapY = 0.0
    }

    func keyboardHeightDifferential(heightDifferential: CGFloat) {
        _tableViewController.changeScrollOffset(diffY: heightDifferential)
    }
}

extension ChatViewController : ChatTableViewControllerDelegate {
    func onChatTableViewActivated() {
        _finishEditing()
    }
}

