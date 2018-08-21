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

    func setChatSource(chatSource: ChatInputBarViewModel.ChatSourcePt?) {
        guard let source = chatSource else {
            _inputBar.model = nil
            return
        }
        _inputBar.model = ChatInputBarViewModel(chatSource: source)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        _inputBar = ChatInputBar(frame: view.bounds)
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
