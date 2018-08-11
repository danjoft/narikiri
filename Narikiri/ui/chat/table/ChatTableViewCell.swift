import UIKit

class ChatTableViewCell: UITableViewCell, CommonUIView {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var balloonLayer: UIView!
    @IBOutlet weak var userName: UILabel!

    private var balloon: TextBalloon!
    private var _model: ChatTableViewCellModel!

    let showDebugLine = false
    
    let frameMargin:CGFloat = 8
    let interMargin:CGFloat = 2

    let subviewMaxSize: CGSize = UIScreen.main.bounds.size

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initNib()

        // for delete xib temporary background
        backgroundColor = .clear
        rootView.backgroundColor = .clear
        balloonLayer.backgroundColor = .clear

        balloon = TextBalloon(maxWidth: subviewMaxSize.width, maxHeight: subviewMaxSize.height)
        balloonLayer.addSubview(balloon)

        if showDebugLine {
            userName.borderWidth = 1
            userName.borderColor = .yellow
            balloonLayer.borderWidth = 1
            balloonLayer.borderColor = .white
            borderWidth = 1
            borderColor = .red
        }
    }

    public var model: ChatTableViewCellModel {
        get {
            return _model
        }
        set {
            _model = newValue
            updateView()
        }
    }

    func updateView() {
        userName.text = _model.charaNickname

        userName.frame.size = userName.sizeThatFits(subviewMaxSize)
        // Must use .sizeThatFits(_) here instead of .sizeToFit(),
        // it is because... the size of userName is needed below,
        // but wouldn't be able to take the accurate size if you just use .sizeToFit() here.

        balloon.text = _model.messageText

        balloonLayer.frame = CGRect(x: frameMargin,
                                    y: userName.bounds.height + interMargin,
                                    width: bounds.width - frameMargin * 2,
                                    height: balloon.bounds.height)
        self.frame.size = CGSize(
            width: bounds.width,
            height: balloonLayer.frame.maxY + frameMargin
        )
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
