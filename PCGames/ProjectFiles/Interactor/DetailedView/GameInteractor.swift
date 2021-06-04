import Foundation

class GameInterator: GameInteractable {
    var service: DataServiceProtocol?
    var gamePresentable: GamePresentable?
    
    func fetchGame(storeID: String) {
        self.service?.get(with: .deals, gameID: storeID, completion: { (response, error) in
            if let failure = error {
                self.gamePresentable?.onFetchGameFailure(with: failure)
            } else {
                let value = response as? [String: Any]
                let gameList = GameDetail(with: value)
                self.gamePresentable?.onFetchGameSuccess(game: gameList)
            }
        })
    }
}
