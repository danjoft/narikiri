import UIKit

class ChatTableViewController: UIViewController {

    var tableView: UITableView!
    weak var delegate: ChatTableViewControllerDelegate?

    private var _viewModel: ChatTableViewModel = NopChatTableViewModelImpl() // default: null object

    func setChatSource(chatSource: ChatTableViewModel.ChatSourcePt?) {
        guard let source = chatSource else {
            _viewModel = NopChatTableViewModelImpl()
            return
        }
        _viewModel = ChatTableViewModelImpl(chatSource: source)
        _viewModel.delegate = self
        tableView.reloadData()
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
        return _viewModel.cellModels.count
    }

}

extension ChatTableViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _getHeight(forRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return _viewModel.cellModels[indexPath.row].type.estimatedHeight
    }

    private func _getHeight(forRowAt indexPath: IndexPath) -> CGFloat {
        let cellSize = _viewModel.getCachedCellSize(at: indexPath.row)
        return cellSize.height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = _viewModel.cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.type.rawValue) as! ChatTableViewCell
        cell.model = cellModel
        cell.layoutIfNeeded()

        return cell
    }
}

extension ChatTableViewController : ChatTableViewModelDelegate {
    func onChatTableViewModelUpdated() {
        tableView.reloadData()
    }
}

protocol ChatTableViewControllerDelegate : class {
    func onChatTableViewActivated()
}
