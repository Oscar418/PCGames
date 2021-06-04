import Foundation

class GamesPresenter: GamesPresentable {
 
    var view: GamesPresenterViewable?
    var interactor: GamesInteractable?
    
    func fetchGame(storeID: String) {
        self.interactor?.fetchGame(storeID: storeID)
    }
    
    func onFetchGameSuccess(game: GameList) {
        self.view?.showOnSuccess(with: game)
    }
    
    func onFetchGameFailure(with error: Error?) {
        self.view?.showOnFailure(with: error)
    }
}
