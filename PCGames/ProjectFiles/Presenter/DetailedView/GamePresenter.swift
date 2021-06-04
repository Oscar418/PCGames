import Foundation

class GamePresenter: GamePresentable {
    var view: GamePresenterViewable?
    var interactor: GameInteractable?
    
    func fetchGame(storeID: String) {
        self.interactor?.fetchGame(storeID: storeID)
    }
    
    func onFetchGameSuccess(game: GameDetail) {
        self.view?.showOnSuccess(with: game)
    }
    
    func onFetchGameFailure(with error: Error?) {
        self.view?.showOnFailure(with: error)
    }
}
