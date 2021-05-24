import UIKit

class ViewController: UIViewController {
    
    var presenter: GamesPresentable?
    var game: Game?
    let dependancyContainer = DependencyContainer.container()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = dependancyContainer.resolve(GamesPresentable.self)
        presenter?.view = self
        fetchGames()
    }
}

extension ViewController: GamesPresenterViewable {
    func showOnSuccess(with game: Game) {
        self.game = game
        displayResults()
        hideBusyView()
    }
    
    func showOnFailure(with error: Error?) {
        hideBusyView()
        let messageLibrary = MessageLibrary(.serverFailure)
        showErrorMessage(library: messageLibrary)
    }
}

extension ViewController {
    
    func fetchGames() {
        guard Reachability.isConnected() else {
            let messageLibrary = MessageLibrary(.network)
            self.showErrorMessage(library: messageLibrary)
            return
        }
        showBusyView()
        presenter?.fetchGame(storeID: "")
    }
    
    func displayResults() {
        print("this is the title \(game?.title)")
    }
}
