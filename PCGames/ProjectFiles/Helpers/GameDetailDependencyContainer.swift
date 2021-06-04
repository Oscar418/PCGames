import Foundation
import Swinject

struct GameDetailDependencyContainer {
    static func container() -> Container {
        let container = Container()
        container.register(GamePresentable.self) { r in
            let presenter = GamePresenter()
            let gameInteractor = GameInterator()
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
