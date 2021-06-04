import Foundation

protocol StorePresentable {
    var view: StoresPresenterViewable?{get set}
    func fetchStores()
    func onFetchStoresSuccess(store: StoreList)
    func onFetchStoresFailure(with error: Error?)
}
