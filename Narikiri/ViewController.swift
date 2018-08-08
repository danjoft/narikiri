//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.backgroundColor = UIColor(red: 120.0/256, green: 146.0/256, blue: 190.0/256, alpha: 1.0)

        let cell = ChatTableViewCell(style: .default, reuseIdentifier: "ChatTableViewCell")
        cell.updateView()
        cell.frame(origin: CGPoint(x: 0, y: 40))
        view.addSubview(cell)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

