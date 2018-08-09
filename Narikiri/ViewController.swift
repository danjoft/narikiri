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

        _tableViewController.cellModels = {()->[ChatTableViewCellModel] in
            let factory = DebugChatRoomFactory()
            let messages = factory.messages(number: 20, charas: factory.charas(number: 3))
            let cellModels = messages.map { (message) -> ChatTableViewCellModel in
                return _ChatTableViewCellModelImpl(message: message )
            }
            return cellModels
        }()

        _secTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] (timer: Timer) in
            if let weakSelf = self {
                print(weakSelf.view.frame)
                print(weakSelf._tableViewController.view.frame)
                print(weakSelf._tableViewController.tableView.frame)
                print(weakSelf._tableViewController.tableView.isScrollEnabled)
                print(weakSelf._tableViewController.tableView.bounds)

                print("---")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

