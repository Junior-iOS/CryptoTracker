//
//  SceneDelegate.swift
//  Easy Numbers
//
//  Created by NJ Development on 11/05/23.
//

import StoreKit
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

                let ac = UIActivityViewController(activityItems: ["https://apps.apple.com/br/app/jogos-lot%C3%A9rica/id\(iTunesID)"],
                                                  applicationActivities: nil)

                if UIDevice.current.userInterfaceIdiom == .pad {
                    let scenes = UIApplication.shared.connectedScenes

                    guard let windowScene = scenes.first as? UIWindowScene,
                          let window = windowScene.windows.first else { return }

                    ac.popoverPresentationController?.sourceView = window
                    ac.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 350)
                    window.rootViewController?.present(ac, animated: true, completion: nil)
                } else {
                    DispatchQueue.main.async {
                        self?.window?.rootViewController?.present(ac, animated: true)
                    }
                }

                NJAnalytics.shared.trackEvent(name: .didShare, from: .quickActions)
            }

        case "SearchAction":
            DispatchQueue.main.async { [weak self] in
                let savedGames = GameManager.shared.retrieveGames()
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
