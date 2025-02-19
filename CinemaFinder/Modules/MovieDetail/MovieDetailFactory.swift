import UIKit

enum MovieDetailFactory {
    static func make(
        navigation: Navigating,
        dependencyContainer: DependencyResolving
    ) -> UIViewController {
        
        let service = MovieDetailService(dependencyContainer: dependencyContainer)
        let presenter = MovieDetailPresenter()
        let interactor = MovieDetailInteractor(
            presenter: presenter,
            dependencyContainer: dependencyContainer,
            service: service
        )
        let controller = MovieDetailViewController(interactor: interactor)
        return controller
    }
}
