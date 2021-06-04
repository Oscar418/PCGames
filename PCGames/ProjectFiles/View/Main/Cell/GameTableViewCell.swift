import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gamePriceLabel: UILabel!
    @IBOutlet weak var gameSalePriceLabel: UILabel!
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
        checkSale()
    }
    
    func loadAssetImage() {
        guard let imageURL = game?.thumbnail else { return }
        guard let url = URL(string: imageURL) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: imageURL)
        gameImage?.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    func checkSale() {
        let salePrice = game?.salePrice ?? ""
        let normalPrice = game?.normalPrice ?? ""
        if salePrice == "0.00" {
            gameSalePriceLabel.isHidden = true
            gamePriceLabel.text = "R\(normalPrice)"
            gamePriceLabel.removeStrikeThrough(text: normalPrice)
        } else {
            gameSalePriceLabel.isHidden = false
            gameSalePriceLabel.text = "R\(salePrice)"
            gamePriceLabel.addStrikeThrough(text: normalPrice)
        }
    }
}
