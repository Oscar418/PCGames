import Foundation

class Store {
    var storeID: String?
    var storeName: String?
    var isActive: Int?
    var storeImages: StoreImages?
    
    init(with dictionary: [String:Any]?) {
        self.storeID = dictionary?["storeID"] as? String
        self.storeName = dictionary?["storeName"] as? String
        self.isActive = dictionary?["isActive"] as? Int
        self.storeImages = StoreImages(with: dictionary?["images"] as? [String:Any])
    }
}
