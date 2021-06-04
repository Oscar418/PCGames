import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gamePriceLabel: UILabel!
    @IBOutlet weak var viewMoreButton: UIButton!
    @IBOutlet weak var gameImage: UIImageView!
    
    var game: Game? {
        didSet {
            populateCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMoreButton.layer.cornerRadius = 6
        viewMoreButton.layer.borderWidth = 0.5
        viewMoreButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func populateCell() {
        gameTitleLabel.text = game?.title
        gamePriceLabel.text = "R\(game?.normalPrice ?? "")"
        loadAssetImage()
    }
    
    func loadAssetImage() {
        guard let imageURL = game?.thumbnail else { return }
        guard let url = URL(string: imageURL) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: imageURL)
        gameImage?.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
