import Foundation

class Game {
    var title: String?
    var salePrice: String?
    var normalPrice: String?
    var isOnSale: String?
    var thumbnail: String?
    
    init(with dictionary: [String: Any]?) {
        self.title = dictionary?["title"] as? String
        self.salePrice = dictionary?["salePrice"] as? String
        self.normalPrice = dictionary?["normalPrice"] as? String
        self.isOnSale = dictionary?["isOnSale"] as? String
        self.thumbnail = dictionary?["thumb"] as? String
    }
}
