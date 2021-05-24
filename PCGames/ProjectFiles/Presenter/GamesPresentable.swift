import Foundation

protocol GamesPresentable {
    var view: GamesPresenterViewable?{get set}
    func fetchGame(storeID: String)
    func onFetchGameSuccess(game: Game)
    func onFetchGameFailure(with error: Error?)
}
