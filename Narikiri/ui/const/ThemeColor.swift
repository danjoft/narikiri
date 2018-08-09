
import UIKit

enum ThemeColor {
    case chatBackBlue
    case chatBalloon

    var uiColor: UIColor {
        get {
            switch self {
            case .chatBackBlue: return UIColor(red: 120.0/256, green: 146.0/256, blue: 190.0/256, alpha: 1.0)
            case .chatBalloon: return UIColor.white
            }
        }
    }
}
