import Foundation

class GamesInterator: GamesInteractable {
    var service: DataServiceProtocol?
    var gamePresentable: GamesPresentable?
    
    func fetchGame(storeID: String) {
        self.service?.get(with: .deals, gameID: storeID, completion: { (response, error) in
            if let failure = error {
                self.gamePresentable?.onFetchGameFailure(with: failure)
            } else {
                let value = response as? [[String: Any]]
                let gameList = GameList(with: value)
                self.gamePresentable?.onFetchGameSuccess(game: gameList)
            }
        })
    }
}
