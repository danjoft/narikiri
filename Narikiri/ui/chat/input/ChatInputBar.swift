//

import UIKit

class ChatInputBar: UIView, CommonUIView {

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    @IBOutlet weak var _inputField: UITextField!
    @IBOutlet weak var _sendButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initNib()
    }

    var textFieldDelegate: UITextFieldDelegate? {
        get {
            return _inputField.delegate
        }
        set {
            _inputField.delegate = newValue
        }
    }
}
