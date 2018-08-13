//

import UIKit

class ChatInputViewController: UIViewController {

    private var _inputBar: ChatInputBar!

    // Should refer after viewDidLoad (means after .view was refered)
    var barHeight: CGFloat {
        get {
            return _inputBar.height
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _inputBar = ChatInputBar(frame: view.bounds)
        _inputBar.textFieldDelegate = self
        view.addSubview(_inputBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _inputBar.frame.size = view.frame.size
    }
}

extension ChatInputViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin")
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return")
        return true
    }
}
