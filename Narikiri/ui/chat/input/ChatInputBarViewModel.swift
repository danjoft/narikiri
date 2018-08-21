class ChatInputBarViewModel {
    typealias ChatSourcePt = ChatSourceGettable & ChatSourceMessageUpdatable & ChatSourceDelegateRegisterable

    // View --(action)-> ViewModel --(update)->  Model
    //      <-(update)--           <-(notify)--

    private var _inputMode: ChatInputBarInputMode
    private var _chatSource: ChatSourcePt
    weak var delegate: ChatInputBarInputModelDelegate?

    init(chatSource: ChatSourcePt) {
        _chatSource = chatSource
        _inputMode = .append
        _chatSource.addDelegate(key: .charasChanged, delegate: self)
        _updateSelectedChara()
    }

    var charas: [ChatChara] {
        return _chatSource.charas
    }

    private var _selectedChara: ChatChara?

    var selectedChara: ChatChara? {
        get {
            return _selectedChara
        }
        set {
            _selectedChara = newValue
            _updateSelectedChara()
            delegate?.onSelectedCharaChanged()
        }
    }

    var isEnableInput: Bool {
        return selectedChara != nil
    }

    func isSendable(text: String) -> Bool {
        if !isEnableInput { return false }
        if text.count <= 0 { return false }
        return true
    }

    func sendText(text:String) -> ChatInputBarSendTextResponse {
        assert(isSendable(text: text), "Not sendable state or text. isEnableInput:\(isEnableInput) text:\(text)")
        _chatSource.appendMessage(text: text, chara: selectedChara!)
        return ChatInputBarSendTextResponse(flushText: true, endEditing: false)
    }

    func _updateSelectedChara() {
        if _chatSource.charas.count == 0 {
            _selectedChara = nil
            return
        }
        let hasSelectedChara = _selectedChara != nil
        let selectedCharaExistsInChatSource =  _chatSource.charas.contains { $0 === _selectedChara }
        let hasAlreadySelected = hasSelectedChara && selectedCharaExistsInChatSource
        if hasAlreadySelected {
            return
        }
        // auto select
        _selectedChara = _chatSource.charas[0]
    }
}

// model -> viewModel
extension ChatInputBarViewModel : ChatSourceDelegate {
    func onChatSourceChanged(eventType: ChatSourceEventType) {
        delegate?.onCharasUpdated() // -> view
    }
}

struct ChatInputBarSendTextResponse {
    var flushText: Bool
    var endEditing: Bool
}

// view -> viewModel
protocol ChatInputBarInputModelDelegate : class {
    func onSelectedCharaChanged()
    func onCharasUpdated()
}

fileprivate enum ChatInputBarInputMode {
    case append
}
