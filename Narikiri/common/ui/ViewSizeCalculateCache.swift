import UIKit

class ViewSizeCalculateCache<View: UIView, ViewModel> {

    private var _template: View
    private var _frameCacheMap: [String: CGRect] = [:]
    private var _updateViewWithData: (View, ViewModel) -> Void

    init(updateViewWithData: @escaping (View, ViewModel) -> Void) {
        _template = View()
        _updateViewWithData = updateViewWithData
    }

    func getFrame(model: ViewModel, cacheKey: String) -> CGRect {
        if let cachedFrame = _frameCacheMap[cacheKey] {
            return cachedFrame
        }
        _updateViewWithData(_template, model)
        let frame = _template.frame
        _frameCacheMap[cacheKey] = frame

        return frame
    }

    func clearCache() {
        _frameCacheMap = [:]
    }
}
