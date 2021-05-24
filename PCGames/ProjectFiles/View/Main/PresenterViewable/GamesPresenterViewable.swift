import Foundation

protocol GamesPresenterViewable {
    func showOnSuccess(with game: Game)
    func showOnFailure(with error: Error?)
}
