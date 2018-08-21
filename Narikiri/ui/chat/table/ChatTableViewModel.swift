import UIKit

protocol ChatTableViewModel {
    typealias ChatSourcePt = ChatSourceGettable & ChatSourceDelegateRegisterable

    var delegate: ChatTableViewModelDelegate? { get set }
    var cellModels: [ChatTableViewCellModel] { get }
    func getCachedCellSize(at: Int) -> CGSize
}

class ChatTableViewModelImpl : ChatTableViewModel, ChatSourceDelegate {

    private var _chatSource: ChatSourcePt

    private var _cellModels: [ChatTableViewCellModel]
    private var _cellSizeCache: ViewSizeCalculateCache<ChatTableViewCell, ChatTableViewCellModel>
    weak var delegate: ChatTableViewModelDelegate?

    init(chatSource: ChatSourcePt) {
        _chatSource = chatSource
        _cellSizeCache = ViewSizeCalculateCache<ChatTableViewCell, ChatTableViewCellModel>(
            updateViewWithData: { (view, viewModel) in
                view.model = viewModel
        })
        _cellModels = type(of: self).__makeCellModelsByChatSource(chatSource: _chatSource)

        _chatSource.addDelegate(key: .messagesChanged, delegate: self)
    }

    private static func __makeCellModelsByChatSource(chatSource: ChatSourceGettable) -> [ChatTableViewCellModel] {
        return chatSource.messages.map { (message) -> ChatTableViewCellModel in
            return _ChatTableViewCellModelImpl(message: message)
        }
    }

    var cellModels: [ChatTableViewCellModel] {
        get {
            return _cellModels
        }
    }

    func getCachedCellSize(at index: Int) -> CGSize {
        let cellModel = cellModels[index]
        let cellFrame = _cellSizeCache.getFrame(model: cellModel, cacheKey: String(cellModel.chatMessageId))
        return cellFrame.size
    }

    func onChatSourceChanged(eventType: ChatSourceEventType) {
        assert(eventType == .messagesChanged)
        _cellSizeCache.clearCache()
        _cellModels = type(of: self).__makeCellModelsByChatSource(chatSource: _chatSource)
        delegate?.onChatTableViewModelUpdated()
    }
}

// Null object for ChatTableViewModel
class NopChatTableViewModelImpl: ChatTableViewModel {
    weak var delegate: ChatTableViewModelDelegate?
    var cellModels: [ChatTableViewCellModel] = []
    func getCachedCellSize(at: Int) -> CGSize {
        assertionFailure("This is null object. Should not be called.")
        return CGSize(width: 0, height: 0)
    }
}

protocol ChatTableViewModelDelegate : class {
    func onChatTableViewModelUpdated()
}
