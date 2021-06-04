import UIKit

class StoreListViewController: UIViewController {
    
    @IBOutlet weak var storeListTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    var storeList: StoreList?
    var storePresenter: StorePresentable?
    let storeDependancyContainer = StoreListDependencyContainer.container()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storePresenter = storeDependancyContainer.resolve(StorePresentable.self)
        storePresenter?.view = self
        setupGamesTableViewCell()
        setSearchFieldDelegate()
        fetchStores()
    }
    
    func setupGamesTableViewCell() {
        let nib = UINib(nibName: "StoreListTableViewCell", bundle: nil)
        storeListTableView.register(nib, forCellReuseIdentifier: "storeListCell")
    }
}

extension StoreListViewController: StoresPresenterViewable {
    func showOnSuccess(with stores: StoreList) {
        self.storeList = stores
        hideBusyView()
        storeListTableView.reloadData()
    }
    
    func showOnFailure(with error: Error?) {
        hideBusyView()
        let messageLibrary = MessageLibrary(.serverFailure)
        showErrorMessage(library: messageLibrary)
    }
}

extension StoreListViewController {
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

extension StoreListViewController: UITextFieldDelegate {
    func setSearchFieldDelegate() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(userTyping), for: UIControl.Event.editingChanged)
    }
}

extension StoreListViewController {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        if searchTextField.text == "" {
            fetchStores()
        } else {
            storeList?.store = storeList?.store?.filter{ $0.storeName?.range(of: searchTextField.text ?? "", options: .caseInsensitive) != nil }
            storeListTableView.reloadData()
        }
        return true
    }
    
    @objc func userTyping() {
        if searchTextField.text == "" {
            fetchStores()
        }
    }
}

extension StoreListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.storeList?.store?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "storeListCell", for: indexPath) as? StoreListTableViewCell {
            cell.store = self.storeList?.store?[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}
