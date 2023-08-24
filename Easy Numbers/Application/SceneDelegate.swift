//
//  SceneDelegate.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import UIKit
import StoreKit

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
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // QUANDO VOLTA
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // QUANDO LEVANTA A TELA
        
    }
}

// MARK: - Shortcut Handler
extension SceneDelegate {
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "ShareAction":
            DispatchQueue.main.async { [weak self] in
                guard let iTunesID = Int(Bundle.main.iTunesID) else { return }
                let vc = SKStoreProductViewController()
                vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber(value: iTunesID)])
                self?.mainCoodinator?.navigationController.present(vc, animated: true)
            }
            
        case "SearchAction":
            DispatchQueue.main.async { [weak self] in
                guard let savedGames = UserDefaults.standard.stringArray(forKey: "SavedGames") else { return }
                if savedGames.isEmpty {
                    let alert = UIAlertController(title: "Ops!",
                                                  message: LocalizableStrings.quickActionsAlert.localized,
                                                  preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default)
                    alert.addAction(ok)
                    self?.window?.rootViewController?.present(alert, animated: true)
                } else {
                    self?.mainCoodinator?.routeToSavedGames(with: savedGames)
                }
            }
            
        case "Results":
            DispatchQueue.main.async { [weak self] in
                self?.mainCoodinator?.routeToInfoVC()
            }
        default: break
        }
    }
}
