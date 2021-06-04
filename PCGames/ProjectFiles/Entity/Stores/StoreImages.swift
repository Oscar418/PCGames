import Foundation

class StoreImages {
    var storeLogo: String?
    
    init(with dictionary: [String:Any]?) {
        self.storeLogo = dictionary?["logo"] as? String
    }
}
