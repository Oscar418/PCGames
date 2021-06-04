import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dealsTableView: UITableView!
    @IBOutlet weak var saleSwitch: UISwitch!
    @IBOutlet weak var onSaleLabel: UILabel!
    @IBOutlet weak var onSaleViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var searchTextField: UITextField!
    var presenter: GamesPresentable?
    var gameList: GameList?
    var storeList: StoreList?
    var storePresenter: StorePresentable?
    let dependancyContainer = DependencyContainer.container()
    let storeDependancyContainer = StoreListDependencyContainer.container()
    var filterIsShown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = dependancyContainer.resolve(GamesPresentable.self)
        storePresenter = storeDependancyContainer.resolve(StorePresentable.self)
        presenter?.view = self
        storePresenter?.view = self
        setupGamesTableViewCell()
        fetchGames()
        fetchStores()
        configureSwitch()
        setSearchFieldDelegate()
    }
    
    func setupGamesTableViewCell() {
        let nib = UINib(nibName: "GameTableViewCell", bundle: nil)
        dealsTableView.register(nib, forCellReuseIdentifier: "gameCell")
    }
    
    func configureSwitch() {
        saleSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        saleSwitch.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
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

extension ViewController: UITextFieldDelegate {
    func setSearchFieldDelegate() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(userTyping), for: UIControl.Event.editingChanged)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            fetchGames()
        } else {
            gameList?.game = gameList?.game?.filter{ $0.title?.range(of: searchTextField.text ?? "", options: .caseInsensitive) != nil }
            dealsTableView.reloadData()
        }
        return true
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.gameList?.game?.count else { return 0 }
        count == 0 ? dealsTableView.setEmptyMessage("No results") : dealsTableView.restore()
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

extension ViewController {
    @objc func switchChanged(mySwitch: UISwitch) {
        let switchStatus = mySwitch.isOn
        if switchStatus == true {
            gameList?.game = gameList?.game?.filter{ $0.salePrice != "0.00" }
            dealsTableView.reloadData()
        } else {
            fetchGames()
        }
    }
    
    @objc func userTyping() {
        if searchTextField.text == "" {
            fetchGames()
        }
    }
}

extension ViewController {
    @IBAction func showFilters(_ sender: Any) {
        if filterIsShown == false {
            onSaleViewHeightConstraint.constant = 80
            onSaleLabel.isHidden = false
            saleSwitch.isHidden = false
        } else {
            onSaleViewHeightConstraint.constant = 45
            onSaleLabel.isHidden = true
            saleSwitch.isHidden = true
        }
        filterIsShown = !filterIsShown
    }
}
