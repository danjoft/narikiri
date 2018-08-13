import UIKit

class ChatTableViewController: UIViewController {

    var tableView: UITableView!
    var delegate: ChatTableViewControllerDelegate?

    var _cellModels: [ChatTableViewCellModel] = []
    private let _cellSizeCache = ViewSizeCalculateCache<ChatTableViewCell, ChatTableViewCellModel>(updateViewWithData: { (view, viewModel) in
        view.model = viewModel
    })

    var cellModels: [ChatTableViewCellModel] {
        get {
            return _cellModels
        }
        set {
            _cellModels = newValue
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.frame = view.frame
        tableView.backgroundColor = ThemeColor.chatBackBlue.uiColor

        tableView.estimatedRowHeight = ChatTableViewCellType.CharaMessage.estimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension

        tableView.separatorStyle = .none

        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCellType.CharaMessage.rawValue)

        // Hack to avoid showing no-cell table view
        tableView.tableFooterView = UIView(frame: .zero)

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(ChatTableViewController._onTapped(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }

    @objc func _onTapped(_ sender: UIGestureRecognizer) {
        delegate?.onChatTableViewActivated()
    }

    func changeScrollOffset(diffY: CGFloat) {
        tableView.contentOffset = CGRect(origin: tableView.contentOffset, size: .zero)
            .offsetBy(dx: 0, dy: -diffY).origin
    }
}

extension ChatTableViewController : UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(section == 0, "Invalid index of sections: \(section)")
        return _cellModels.count
    }

}

extension ChatTableViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _getHeight(forRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return _cellModels[indexPath.row].type.estimatedHeight
    }

    private func _getHeight(forRowAt indexPath: IndexPath) -> CGFloat {
        let cellModel = _cellModels[indexPath.row]
        let frame = _cellSizeCache.getFrame(model: cellModel, cacheKey: String(cellModel.chatMessageId))
        return frame.size.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = _cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.type.rawValue) as! ChatTableViewCell
        cell.model = cellModel
        cell.layoutIfNeeded()

        return cell
    }
}

protocol ChatTableViewControllerDelegate {
    func onChatTableViewActivated()
}
