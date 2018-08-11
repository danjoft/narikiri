import Foundation
import UIKit

class BalloonContainer: UIView, CommonUIView {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var contentArea: UIView!

    static let margin = CGFloat(10.0)
    private weak var _content: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initNib()
    }

    convenience init(content: UIView) {
        self.init(frame: .zero)
        self.content = content
    }

    var content: UIView {
        set {
            _content = newValue
            updateView()
        }
        get {
            return _content
        }
    }

    var balloonColor: UIColor? {
        set {
            background.backgroundColor = newValue
        }
        get {
            return background.backgroundColor
        }
    }

    var margin: CGFloat {
        get {
            return BalloonContainer.margin
        }
    }

    private func updateView() {
        for subview in contentArea.subviews {
            subview.removeFromSuperview()
        }
        contentArea.addSubview(_content)
        _content.frame.size = _content.bounds.size
        let margin = self.margin
        contentArea.frame = CGRect(origin: CGPoint(x: margin, y: margin),
                                   size: _content.bounds.size)
        background.frame.size = CGSize(
            width: contentArea.bounds.size.width + margin * 2,
            height: contentArea.bounds.size.height + margin * 2)
        contentArea.backgroundColor = nil

        self.frame.size = background.bounds.size
        // if you change self.bounds.size here, the frame.origin automatically
        // gets changed with keeping center position.
        // (When the bounds size is changed, frame.origin gets automatically
        //  changed so as to keep center position)
    }
}
