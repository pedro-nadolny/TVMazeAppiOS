import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let controller = DependencyContainer.shared
            .seriesCatalogFactory
            .makeSeriesCatalog(with: DependencyContainer.shared)
        
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.prefersLargeTitles = true

        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
