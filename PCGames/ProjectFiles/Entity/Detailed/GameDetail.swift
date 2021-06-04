import Foundation

class GameDetail {
    var gameDetailed: GameDetailed?
    var cheaperStores: [StoreDetail]?
    
    init(with dictionary: [String: Any]?) {
        self.gameDetailed = GameDetailed(with: dictionary?["gameInfo"] as? [String:Any])
        self.cheaperStores = [StoreDetail]()
        guard let stores = dictionary?["cheaperStores"] as? [[String:Any]] else { return }
        for item in stores {
            self.cheaperStores?.append(StoreDetail(with: item))
        }
    }
}
