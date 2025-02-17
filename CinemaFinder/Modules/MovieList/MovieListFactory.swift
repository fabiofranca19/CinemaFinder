import UIKit

enum MovieListFactory {
    static func make(
        navigation: Navigating,
        dependencyContainer: DependencyResolving
    ) -> UIViewController {
        let service = MovieListService(dependencyContainer: dependencyContainer)
        let coordinator = MovieListCoordinator(navigation)
        let presenter = MovieListPresenter(coordinator: coordinator)
        let interactor = MovieListInteractor(
            presenter: presenter,
            service: service,
            dependencyContainer: dependencyContainer
        )
        let controller = MovieListViewController(interactor: interactor)
        
        presenter.viewController = controller
        
        return controller
    }
}
