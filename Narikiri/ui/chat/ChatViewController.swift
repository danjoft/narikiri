//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var _tableLayer: UIView!
    @IBOutlet weak var _inputLayer: UIView!

    var _tableViewController: ChatTableViewController!
    var _inputViewController: ChatInputViewController!

    private var _keyboardObserver: KeyboardFrameObserver!
    private var _keyboardOverlapY: CGFloat = 0

    @IBAction func _onTapTableLayer(_ sender: UITapGestureRecognizer) {
        _finishEditing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _tableViewController = ChatTableViewController()
        _tableLayer.addSubview(_tableViewController.view)

        _inputViewController = ChatInputViewController()
        _inputLayer.addSubview(_inputViewController.view)

        _keyboardObserver = KeyboardFrameObserver()
        _keyboardObserver.delegate = self

        // setup mock data
        _tableViewController.cellModels = {()->[ChatTableViewCellModel] in
            let factory = DebugChatRoomFactory()
            let messages = factory.messages(number: 20, charas: factory.charas(number: 3))
            let cellModels = messages.map { (message) -> ChatTableViewCellModel in
                return _ChatTableViewCellModelImpl(message: message )
            }
            return cellModels
        }()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func _finishEditing() {
        view.endEditing(true)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let tableLayerHeight = view.frame.height - _inputLayer.frame.size.height - _keyboardOverlapY
        let tableFrame = CGRect(
            origin: view.frame.origin,
            size: CGSize(
                width: view.frame.width, height: tableLayerHeight)
        )
        _tableLayer.frame = tableFrame
        _inputLayer.frame.origin = view.frame.offsetBy(dx: 0, dy: tableFrame.maxY).origin

        _tableViewController.view.frame = tableFrame
        _inputViewController.view.frame.size = _inputLayer.frame.size
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
}

