import Foundation

protocol GamesPresenterViewable {
    func showOnSuccess(with game: GameList)
    func showOnFailure(with error: Error?)
}
