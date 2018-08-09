//

import UIKit

class ChatTableViewController: UIViewController {

    var tableView: UITableView!

    var _cellModels: [ChatTableViewCellModel] = []
    fileprivate let _cellHeightCache: _CellHeightCache = _CellHeightCache()

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

        let factory = DebugChatRoomFactory()
        let messages = factory.messages(number: 20, charas: factory.charas(number: 3))
        _cellModels = messages.map { (message) -> ChatTableViewCellModel in
            return _ChatTableViewCellModelImpl(message: message )
        }

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let height = _cellHeightCache.getHeight(model: cellModel, cacheKey: cellModel.chatMessageId)
        return height
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = _cellModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.type.rawValue) as! ChatTableViewCell
        cell.model = cellModel
        cell.layoutIfNeeded()

        return cell
    }
}

fileprivate class _CellHeightCache {
    private var _cellTemplate: ChatTableViewCell
    private var _heightMap: [Int: CGFloat] = [:]

    init() {
        _cellTemplate = ChatTableViewCell(style: .default, reuseIdentifier: "dummy")
    }

    func getHeight(model: ChatTableViewCellModel, cacheKey: Int) -> CGFloat {
        if let cachedHeight = _heightMap[cacheKey] {
            return cachedHeight
        }
        _setViewModelToView(viewModel: model)
        let height = _cellTemplate.bounds.height
        _heightMap[cacheKey] = height
        return height
    }

    func clear() {
        _heightMap = [:]
    }

    func _setViewModelToView(viewModel: ChatTableViewCellModel) {
        _cellTemplate.model = viewModel
    }
}
