import Foundation
import Swinject

struct StoreListDependencyContainer {
    static func container() -> Container {
        let container = Container()
        container.register(StorePresentable.self) { r in
            let presenter = StorePresenter()
            let storeInteractor = StoreInterator()
            presenter.interactor = storeInteractor
            storeInteractor.service = r.resolve(DataServiceProtocol.self)
            storeInteractor.storePresentable = presenter
            return presenter
        }
        container.register(DataServiceProtocol.self) { r in
            return DataService()
        }
        return container
    }
}
