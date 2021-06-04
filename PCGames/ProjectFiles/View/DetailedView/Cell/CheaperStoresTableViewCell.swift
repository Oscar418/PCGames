import UIKit

class CheaperStoresTableViewCell: UITableViewCell {

    @IBOutlet weak var shopNameLabel: UILabel!
    @IBOutlet weak var viewDealButton: UIButton!
    var storeList: StoreList? {
        didSet{
            populateCell()
        }
    }
    var store: StoreDetail? 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewDealButton.layer.cornerRadius = 6
        viewDealButton.layer.borderWidth = 0.5
        viewDealButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func populateCell() {
        shopNameLabel.text = getStoreName()
    }
    
    func getStoreName() -> String {
        let stores = storeList?.store?.count ?? 0
        for i in 0..<stores {
            let storeID = storeList?.store?[i].storeID
            if storeID == store?.storeID {
                let storeName = storeList?.store?[i].storeName ?? ""
                return storeName
            }
        }
        return ""
    }
}
