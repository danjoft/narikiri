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
    @IBAction func _onSendButtonTouched(_ sender: UIButton) {
        _sendText()
    }

    private var _editingText: String?
    private var _inputFieldObservable: TextFieldObservable!

    var model: ChatInputBarViewModel? {
        didSet {
            model?.delegate = self
            _updateView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
        _initCommon()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initNib()
        _initCommon()
    }

    private func _initCommon() {
        _inputFieldObservable = TextFieldObservableImpl(textField: _inputField)
        _inputFieldObservable.onChanged { [unowned self] in
            self._updateView()
        }
        _updateView()
    }

    var height: CGFloat {
        get {
            return 45.0
        }
    }

    func _updateView() {
        let isInputEnable = model?.isEnableInput ?? false
        let isNowSendable = isInputEnable && _inputFieldObservable.isTextExists
        print(_inputFieldObservable.isTextExists)
        _sendButton.isEnabled = isNowSendable
        _inputField.isEnabled = isInputEnable
        // TODO: update view by model.charas
        // TODO: update view by model.selectedChara
        setNeedsDisplay()
    }

    func _sendText() {
        guard let text = _inputField.text else {
            return
        }
        if !(model?.isSendable(text: text) ?? false) {
            return
        }

        guard let response = model?.sendText(text: text) else {
            return
        }
        if response.flushText {
            _inputField.text = ""
        }
        if response.endEditing {
            self.endEditing(true)
        }
        _inputFieldObservable.synchronizeEditingText()
        _updateView()
    }
}

extension ChatInputBar: ChatInputBarInputModelDelegate {
    func onSelectedCharaChanged() {
        _updateView()
    }
    func onCharasUpdated() {
        _updateView()
    }
}
