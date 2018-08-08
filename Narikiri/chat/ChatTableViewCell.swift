import UIKit

class ChatTableViewCell: UITableViewCell, CommonUIView {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var balloonLayer: UIView!
    @IBOutlet weak var userName: UILabel!

    private var balloon: TextBalloon!

    let showDebugLine = false
    let frameMargin:CGFloat = 8
    let interMargin:CGFloat = 2

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initNib()

        rootView.backgroundColor = .clear
        balloonLayer.backgroundColor = .clear

        balloon = TextBalloon(text: "")
        balloonLayer.addSubview(balloon)

        if showDebugLine {
            balloonLayer.borderWidth = 1
            balloonLayer.borderColor = .white
            borderWidth = 1
            borderColor = .red
        }
    }

    func updateView() {
        balloon.text = "うんこうんこうんこしようぜえええ！！！"
        userName.text = "ウンコマン"
        userName.sizeToFit()

        balloonLayer.frame = CGRect(x: frameMargin,
                                    y: userName.bounds.height + interMargin,
                                    width: bounds.width - frameMargin * 2,
                                    height: balloon.bounds.height)
        bounds = CGRect(origin: CGPoint.zero,
                        size: CGSize(
                            width: frame.width,
                            height: balloonLayer.frame.maxY + frameMargin))
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

