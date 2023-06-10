//
//  SceneDelegate.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var mainCoodinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        mainCoodinator = MainCoordinator()
        mainCoodinator?.start()
        
        let navigation = mainCoodinator?.navigationController
        navigation?.overrideUserInterfaceStyle = .dark
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}
