import Foundation

class StoreDetail {
    var storeID: String?
    var dealID: String?
    
    init(with dictionary: [String:Any]?) {
        self.storeID = dictionary?["storeID"] as? String
        self.dealID = dictionary?["dealID"] as? String
    }
}
