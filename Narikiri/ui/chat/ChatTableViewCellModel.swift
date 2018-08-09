import Foundation

// This is the ViewModel interface for ChatTableViewCell.
protocol ChatTableViewCellModel {
    var chatMessageId: Int { get }
    var type: ChatTableViewCellType { get }
    var messageText: String { get }
    var charaNickname: String { get }
}

// The owner of this shall only be view-controller (but not view).
internal class _ChatTableViewCellModelImpl : ChatTableViewCellModel {
    let message: ChatMessage // shall not be accecced from view but only view-controller.

    init(message: ChatMessage) {
        self.message = message
    }

    var chatMessageId: Int {
        get {
            return message.id
        }
    }

    var type: ChatTableViewCellType {
        get {
            return .CharaMessage
            // TODO: choose type
        }
    }

    var messageText: String {
        get {
            return message.text
        }
    }

    var charaNickname: String {
        get {
            return message.chara.nickname
        }
    }
}
