import Foundation

protocol GamePresentable {
    var view: GamePresenterViewable?{get set}
    func fetchGame(storeID: String)
    func onFetchGameSuccess(game: GameDetail)
    func onFetchGameFailure(with error: Error?)
}
