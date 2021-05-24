import Foundation
import Swinject

struct DependencyContainer {
    
    static func container() -> Container {
        let container = Container()
        container.register(GamesPresentable.self) { r in
            let presenter = GamesPresenter()
            let gameInteractor = GamesInterator()
            presenter.interactor = gameInteractor
            gameInteractor.service = r.resolve(DataServiceProtocol.self)
            gameInteractor.gamePresentable = presenter
            return presenter
        }
        container.register(DataServiceProtocol.self) { r in
            return DataService()
        }
        return container
    }
}
