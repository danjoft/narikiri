//

import UIKit

class ViewController: UIViewController {

    var _secTimer: Timer!
    var _tableViewController: ChatTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        _tableViewController = ChatTableViewController()
        _tableViewController.view.frame = view.bounds
        view.addSubview(_tableViewController.view)

        _secTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer: Timer) in
            if let weakSelf = self {
                print(weakSelf._tableViewController.view.subviews)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

