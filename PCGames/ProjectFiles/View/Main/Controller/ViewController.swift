import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dealsTableView: UITableView!
    var presenter: GamesPresentable?
    var gameList: GameList?
    var storeList: StoreList?
    var storePresenter: StorePresentable?
    let dependancyContainer = DependencyContainer.container()
    let storeDependancyContainer = StoreListDependencyContainer.container()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = dependancyContainer.resolve(GamesPresentable.self)
        storePresenter = storeDependancyContainer.resolve(StorePresentable.self)
        presenter?.view = self
        storePresenter?.view = self
        setupGamesTableViewCell()
        fetchGames()
        fetchStores()
    }
    
    func setupGamesTableViewCell() {
        let nib = UINib(nibName: "GameTableViewCell", bundle: nil)
        dealsTableView.register(nib, forCellReuseIdentifier: "gameCell")
    }
}

extension ViewController: GamesPresenterViewable {
    func showOnSuccess(with game: GameList) {
        self.gameList = game
        hideBusyView()
        dealsTableView.reloadData()
    }
    
    func showOnFailure(with error: Error?) {
        hideBusyView()
        let messageLibrary = MessageLibrary(.serverFailure)
        showErrorMessage(library: messageLibrary)
    }
}

extension ViewController: StoresPresenterViewable {
    func showOnSuccess(with stores: StoreList) {
        self.storeList = stores
    }
}

extension ViewController {
    func fetchGames() {
        guard Reachability.isConnected() else {
            let messageLibrary = MessageLibrary(.network)
            self.showErrorMessage(library: messageLibrary)
            return
        }
        showBusyView()
        presenter?.fetchGame(storeID: "")
    }
    
    func fetchStores() {
        guard Reachability.isConnected() else {
            let messageLibrary = MessageLibrary(.network)
            self.showErrorMessage(library: messageLibrary)
            return
        }
        showBusyView()
        storePresenter?.fetchStores()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.gameList?.game?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as? GameTableViewCell {
            cell.game = self.gameList?.game?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DealViewStoryboard", bundle: nil)
        let dealDetailViewController = storyboard.instantiateViewController(withIdentifier: "dealsDetailViewController") as! DealsDetailViewController
        dealDetailViewController.gameID = gameList?.game?[indexPath.row].gameID
        dealDetailViewController.storeList = storeList
        self.present(dealDetailViewController, animated: true, completion: nil)
    }
}
