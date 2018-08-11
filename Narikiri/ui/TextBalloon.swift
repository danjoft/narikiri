import UIKit

class TextBalloon: UIView, CommonUIView {

    private var _text: String
    private var _label: UILabel
    private var _container: BalloonContainer
    var maxWidth: CGFloat
    var maxHeight: CGFloat

    init(text: String, maxWidth: CGFloat = 200.0, maxHeight: CGFloat = 2000.0) {
        _label = UILabel(frame: .zero)
        _text  = text
        _container = BalloonContainer(content: _label)
        self.maxWidth  = maxWidth
        self.maxHeight = maxHeight

        super.init(frame: .zero)

        _container.addSubview(_label)
        addSubview(_container)
        
        updateView()
    }

    convenience init(maxWidth: CGFloat = 200.0, maxHeight: CGFloat = 2000.0) {
        self.init(text: "", maxWidth: maxWidth, maxHeight: maxHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var text: String {
        get {
            return _text
        }
        set {
            _text = newValue
            updateView()
        }
    }

    var balloonColor: UIColor? {
        get {
            return _container.balloonColor
        }
        set {
            _container.balloonColor = newValue
        }
    }

    private func updateView() {
        _label.text = _text
        _label.numberOfLines = 0
        _label.frame.size = _label.sizeThatFits(CGSize(
            width:  maxWidth - _container.margin * 2,
            height: maxHeight - _container.margin * 2))
        _container.content = _label
        self.frame.size = _container.frame.size
    }
}
