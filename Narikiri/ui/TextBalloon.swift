import UIKit

class TextBalloon: UIView, CommonUIView {

    private var _text: String
    private var _label: UILabel
    private var _container: BalloonContainer
    var maxWidth: CGFloat
    var maxHeight: CGFloat

    init(text: String, maxWidth: CGFloat = 200.0, maxHeight: CGFloat = 2000.0) {
        self._label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self._text  = text
        self._container = BalloonContainer(content: _label)
        self.maxWidth  = maxWidth
        self.maxHeight = maxHeight
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

        self._container.addSubview(_label)
        self.addSubview(_container)
        
        self.updateView()
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

    private func updateView() {
        _label.text = _text
        _label.numberOfLines = 0
        _label.bounds = CGRect(x: 0, y: 0,
                               width: maxWidth - _container.margin * 2,
                               height: maxHeight - _container.margin * 2)
        _label.sizeToFit()
        _container.content = _label
        frame(size: _container.frame.size)
    }
}
