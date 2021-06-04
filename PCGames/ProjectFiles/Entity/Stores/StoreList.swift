import Foundation

class StoreList {
    var store: [Store]?
    
    init(with dictionary: [[String: Any]]?) {
        self.store = [Store]()
        guard let stores = dictionary else { return }
        for item in stores {
            self.store?.append(Store(with: item))
        }
    }
}
