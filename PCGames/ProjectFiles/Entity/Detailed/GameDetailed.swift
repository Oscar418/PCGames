import Foundation

class GameDetailed {
    var storeID: String?
    var gameID: String?
    var title: String?
    var salePrice: String?
    var normalPrice: String?
    var thumbnail: String?
    
    init(with dictionary: [String:Any]?) {
        self.storeID = dictionary?["storeID"] as? String
        self.gameID = dictionary?["gameID"] as? String
        self.title = dictionary?["name"] as? String
        self.salePrice = dictionary?["salePrice"] as? String
        self.normalPrice = dictionary?["retailPrice"] as? String
        self.thumbnail = dictionary?["thumb"] as? String
    }
}
