import UIKit
import Kingfisher

class StoreListTableViewCell: UITableViewCell {

    @IBOutlet weak var StoreImageView: UIImageView!
    @IBOutlet weak var storeNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    
    var store: Store? {
        didSet {
            populateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMoreButton.layer.cornerRadius = 6
        viewMoreButton.layer.borderWidth = 0.5
        viewMoreButton.layer.borderColor = UIColor.black.cgColor
    }
    
    func populateCell() {
        storeNameLabel.text = store?.storeName
        statusLabel.text = store?.isActive == 1 ? "Active" : "Offline"
        loadAssetImage()
    }
    
    func loadAssetImage() {
        let baseUrl = "https://www.cheapshark.com"
        guard let imageURL = store?.storeImages?.storeLogo else { return }
        let downloadUrl = baseUrl + imageURL
        guard let url = URL(string: downloadUrl) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: imageURL)
        StoreImageView?.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
