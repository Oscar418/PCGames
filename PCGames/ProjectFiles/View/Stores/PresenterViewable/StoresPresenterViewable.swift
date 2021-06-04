import Foundation

protocol StoresPresenterViewable {
    func showOnSuccess(with stores: StoreList)
    func showOnFailure(with error: Error?)
}
