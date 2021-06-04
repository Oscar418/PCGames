import Foundation

class StorePresenter: StorePresentable {
   
    var view: StoresPresenterViewable?
    var interactor: StoreInteractable?
    
    func fetchStores() {
        self.interactor?.fetchStores()
    }
    
    func onFetchStoresSuccess(store: StoreList) {
        self.view?.showOnSuccess(with: store)
    }
    
    func onFetchStoresFailure(with error: Error?) {
        self.view?.showOnFailure(with: error)
    }
}
