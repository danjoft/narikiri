//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        label.text = "こんにちは。わたしの名前はひみつです。ウヒヒヒヒ。"
//        label.backgroundColor = UIColor.red

        view.backgroundColor = UIColor(red: 120.0/256, green: 146.0/256, blue: 190.0/256, alpha: 1.0)

        label.numberOfLines = 0
        label.bounds = CGRect(
            origin: CGPoint(x: 0, y: 0),
            size: label.sizeThatFits(CGSize(width: 200, height: 3000)))
        label.sizeToFit()

        let balloon = BalloonContainer(content: label)
        balloon.balloonColor = UIColor.white

        balloon.frame(origin: CGPoint(x: 10, y: 200))

        view.addSubview(balloon)

        ({
            let balloon = TextBalloon(text: "うんこまるまるもりもりうんこ元気だよたべてねパクパク")
            view.addSubview(balloon)
        })()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

