import UIKit

protocol CommonUIView {
}

extension CommonUIView where Self : UIView {
    func initNib() {
        let nibName = String(describing: type(of: self))
        let nib = UINib(nibName: nibName, bundle: nil)
        let nibRoot = nib.instantiate(withOwner: self, options: nil).first as! UIView

        nibRoot.frame = self.bounds
        nibRoot.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.addSubview(nibRoot)
    }

    // Change only the origin of frame
    func frame(origin: CGPoint) {
        self.frame = CGRect(
            origin: origin,
            size: self.frame.size
        )
    }

    // Change only the size of frame
    func frame(size: CGSize) {
        self.frame = CGRect(
            origin: self.frame.origin,
            size: size
        )
    }
}

extension UIView {

    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
