import Foundation

class GameList {
    var game: [Game]?
    
    init(with dictionary: [[String: Any]]?) {
        self.game = [Game]()
        guard let games = dictionary else { return }
        for item in games {
            self.game?.append(Game(with: item))
        }
    }
}
