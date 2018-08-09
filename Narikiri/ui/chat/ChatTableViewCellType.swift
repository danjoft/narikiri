import UIKit

// This will be used for cellIdentifier of TableView
enum ChatTableViewCellType : String {
    case CharaMessage
    case SystemMessage
}

extension ChatTableViewCellType {
    var cellIdentifier: String {
        get {
            return rawValue
        }
    }

    var estimatedHeight: CGFloat {
        get {
            // TODO: set the accurate values
            switch self {
            case .CharaMessage:  return 100
            case .SystemMessage: return 40
            }
        }
    }
}
