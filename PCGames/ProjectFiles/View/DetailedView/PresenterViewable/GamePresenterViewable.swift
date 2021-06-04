import Foundation

protocol GamePresenterViewable {
    func showOnSuccess(with game: GameDetail)
    func showOnFailure(with error: Error?)
}
