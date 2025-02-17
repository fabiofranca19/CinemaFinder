import UIKit

protocol Navigating {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func popViewController(animated: Bool, completion: (() -> Void)?)
}

class AppCoordinator: Navigating {
    private weak var navigationController: UINavigationController?
    private let dependencyContainer: DependencyResolving

    init(
        navigationController: UINavigationController,
        dependencyContainer: DependencyResolving
    ) {
        self.navigationController = navigationController
        self.dependencyContainer = dependencyContainer
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func popViewController(animated: Bool, completion: (() -> Void)?) {
        guard let navigationController = navigationController else { return }
        
        completion?()
        
        navigationController.popViewController(animated: animated)
    }

    func start() {
        let movieListViewController = MovieListFactory.make(
            navigation: self,
            dependencyContainer: dependencyContainer
        )
        navigationController?.setViewControllers([movieListViewController], animated: false)
    }
}
