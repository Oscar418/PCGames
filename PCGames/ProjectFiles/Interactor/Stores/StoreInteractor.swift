import Foundation

class StoreInterator: StoreInteractable {
    var service: DataServiceProtocol?
    var storePresentable: StorePresentable?
    
    func fetchStores() {
        self.service?.get(with: .stores, gameID: "", completion: { (response, error) in
            if let failure = error {
                self.storePresentable?.onFetchStoresFailure(with: failure)
            } else {
                let value = response as? [[String: Any]]
                let storeList = StoreList(with: value)
                self.storePresentable?.onFetchStoresSuccess(store: storeList)
            }
        })
    }
}
