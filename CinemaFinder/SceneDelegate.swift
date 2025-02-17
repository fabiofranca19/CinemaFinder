import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        
        let dependencyContainer = DependencyContainer()
        dependencyContainer.register(Servicing.self) {
            ServiceApi()
        }

        let appCoordinator = AppCoordinator(
            navigationController: navigationController,
            dependencyContainer: dependencyContainer
        )
        self.appCoordinator = appCoordinator
        appCoordinator.start()

        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
    
}

