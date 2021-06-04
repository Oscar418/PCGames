import Foundation

class Store {
    var storeID: String?
    var storeName: String?
    
    init(with dictionary: [String:Any]?) {
        self.storeID = dictionary?["storeID"] as? String
        self.storeName = dictionary?["storeName"] as? String
    }
}
