//
//  SceneDelegate.swift
//  Flags
//
//  Created by admin on 18/07/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { fatalError() }
        let navigationController: UINavigationController = UINavigationController()
        let appCoordinator: AppCoordinator = .init(navigationController: navigationController)
        self.window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator.start()
    }
}
