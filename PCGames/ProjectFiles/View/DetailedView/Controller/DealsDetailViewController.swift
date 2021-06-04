import UIKit
import Kingfisher

class DealsDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var retailPriceLabel: UILabel!
    @IBOutlet weak var salePriceLabel: UILabel!
    @IBOutlet weak var saveAmountLabel: UILabel!
    @IBOutlet weak var storesAvailableLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var cheaperStoresTableView: UITableView!
    var gameID: String?
    var storeList: StoreList?
    var gameDetails: GameDetail?
    var presenter: GamePresentable?
    let dependancyContainer = GameDetailDependencyContainer.container()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = dependancyContainer.resolve(GamePresentable.self)
        presenter?.view = self
        fetchGameDetails()
        setupCheaperStoresTableViewCell()
    }
    
    func setupCheaperStoresTableViewCell() {
        let nib = UINib(nibName: "CheaperStoresTableViewCell", bundle: nil)
        cheaperStoresTableView.register(nib, forCellReuseIdentifier: "cheaperStoresCell")
    }
}

extension DealsDetailViewController: GamePresenterViewable {
    func showOnSuccess(with game: GameDetail) {
        self.gameDetails = game
        hideBusyView()
        displayData()
    }
    
    func showOnFailure(with error: Error?) {
        hideBusyView()
        let messageLibrary = MessageLibrary(.serverFailure)
        showErrorMessage(library: messageLibrary)
    }
}

extension DealsDetailViewController {
    func fetchGameDetails() {
        guard Reachability.isConnected() else {
            let messageLibrary = MessageLibrary(.network)
            self.showErrorMessage(library: messageLibrary)
            return
        }
        showBusyView()
        presenter?.fetchGame(storeID: gameID ?? "")
    }
    
    func getStoreName() {
        let stores = storeList?.store?.count ?? 0
        for i in 0..<stores {
            let storeID = storeList?.store?[i].storeID
            if storeID == gameDetails?.gameDetailed?.storeID {
                storesAvailableLabel.text = "Available at \(storeList?.store?[i].storeName ?? "")"
            }
        }
    }
    
    func displayData() {
        titleLabel.text = gameDetails?.gameDetailed?.title ?? ""
        salePriceLabel.text = "R\(gameDetails?.gameDetailed?.salePrice ?? "")"
        saveAmountLabel.text = "You save R\(String(format: "%.2f", calculateSaveAmount()))"
        checkSale()
        loadAssetImage()
        getStoreName()
        cheaperStoresTableView.reloadData()
    }
    
    func checkSale() {
        let salePrice = gameDetails?.gameDetailed?.salePrice ?? ""
        let normalPrice = gameDetails?.gameDetailed?.normalPrice ?? ""
        if salePrice == "0.00" {
            salePriceLabel.isHidden = true
            saveAmountLabel.isHidden = true
            retailPriceLabel.text = "R\(normalPrice)"
        } else {
            retailPriceLabel.addStrikeThrough(text: normalPrice)
        }
    }
    
    func loadAssetImage() {
        guard let imageURL = gameDetails?.gameDetailed?.thumbnail else { return }
        guard let url = URL(string: imageURL) else { return }
        let resource = ImageResource(downloadURL: url, cacheKey: imageURL)
        gameImageView?.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    func calculateSaveAmount() -> Double {
        let normalPrice = Double(gameDetails?.gameDetailed?.normalPrice ?? "") ?? 0.0
        let salePrice = Double(gameDetails?.gameDetailed?.salePrice ?? "") ?? 0.0
        let discount = normalPrice - salePrice
        return discount
    }
}

extension DealsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.gameDetails?.cheaperStores?.count else { return 0 }
        count == 0 ? cheaperStoresTableView.setEmptyMessage("No cheaper stores") : cheaperStoresTableView.restore()
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cheaperStoresCell", for: indexPath) as? CheaperStoresTableViewCell {
            cell.store = self.gameDetails?.cheaperStores?[indexPath.row]
            cell.storeList = self.storeList
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dealID = self.gameDetails?.cheaperStores?[indexPath.row].dealID
        gameID = dealID
        fetchGameDetails()
    }
}
