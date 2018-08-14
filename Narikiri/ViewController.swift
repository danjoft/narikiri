//

import UIKit

class ViewController: UIViewController {

    var _secTimer: Timer!
    var _chatViewController: ChatViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        _chatViewController = ChatViewController()
        addChildViewController(_chatViewController)
        view.addSubview(_chatViewController.view)
        _chatViewController.didMove(toParentViewController: self)


//        _secTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] (timer: Timer) in
//            guard let weakSelf = self else {
//                return
//            }
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        _chatViewController.view.frame = view.frame
    }

}

