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
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(content: UIView) {
        self.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        self.content = content
    }

    var content: UIView {
        set {
            self._content = newValue
            self.updateView()
        }
        get {
            return self._content
        }
    }

    var balloonColor: UIColor? {
        set {
            self.background.backgroundColor = newValue
        }
        get {
            return self.background.backgroundColor
        }
    }

    private func updateView() {
        for subview in self.contentArea.subviews {
            subview.removeFromSuperview()
        }
        self.contentArea.addSubview(self._content)
        self._content.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: _content.bounds.size)
        let margin = BalloonContainer.margin
        self.contentArea.frame = CGRect(origin: CGPoint(x: margin, y: margin),
                                         size: _content.bounds.size)
        self.background.frame = CGRect(x: 0, y: 0,
                                       width: contentArea.bounds.size.width + margin * 2,
                                       height: contentArea.bounds.size.height + margin * 2)
        self.contentArea.backgroundColor = nil
        self.frame(size:
            CGSize(
                width:  self.background.bounds.width,
                height: self.background.bounds.height
            )
        )
    }
}
