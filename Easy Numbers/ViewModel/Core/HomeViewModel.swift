//
//  HomeViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 12/05/23.
//

import Foundation
import OnboardingKit
import FirebaseRemoteConfig
import UIKit

// MARK: - Protocol
protocol HomeViewModelDelegate: AnyObject {
    func handlePresentOnboarding()
    func didTapNextButton()
    func didTapGetStarted()
    func handleRemoteConfig(with value: Bool)
}

final class HomeViewModel {
    // MARK: - Properties
    
    var onboardingKit: OnboardingKit?
    weak var delegate: HomeViewModelDelegate?
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    var result: [Int]?
    
    var navTitle: String {
        Bundle.main.appName
    }
    
    var myGamesButtonTitle: String {
        "Meus jogos"
    }

    // MARK: - Methods
    func presentOnboardingKit() {
        DispatchQueue.main.async {
            self.onboardingKit = OnboardingKit(
                slides: [
                    Slide(image: UIImage(named: "copy_game") ?? UIImage(), title: "Clique para copiar seu jogo!"),
                    Slide(image: UIImage(named: "save_game") ?? UIImage(), title: "Salve seu jogo para fazer sua aposta mais tarde. =)"),
                    Slide(image: UIImage(named: "share_delete_games") ?? UIImage(), title: "Compartilhe ou apague todos os seus jogos."),
                    Slide(image: UIImage(named: "share_delete_individual_games") ?? UIImage(), title: "Compartilhe ou apague todos os seus jogos individualmente.")
                ],
                tintColor: UIColor(red: 220 / 255, green: 20 / 255, blue: 60 / 255, alpha: 1),
                font: UIFont(name: "Kohinoor Bangla", size: 28) ?? .systemFont(ofSize: 28, weight: .bold)
            )

            self.onboardingKit?.delegate = self
            self.delegate?.handlePresentOnboarding()
        }
    }

    private func createWindowScene(with viewController: UIViewController) {
        let foregroundScenes = UIApplication.shared.connectedScenes.filter({
            $0.activationState == .foregroundActive
        })

        let window = foregroundScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?
            .windows
            .filter({ $0.isKeyWindow })
            .first

        guard let uiWindow = window else { return }
        uiWindow.rootViewController = viewController

        UIView.transition(with: uiWindow, duration: 0.3, options: [.transitionCrossDissolve], animations: nil)
    }

    func generate(_ gameType: GameType) -> [Int] {
        result = []

        switch gameType {
        case .megasena:
            result = generateNumbers(total: 6, universe: 60)

        case .lotofacil:
            result = generateNumbers(total: 15, universe: 25)

        case .quina:
            result = generateNumbers(total: 5, universe: 80)

        case .lotomania:
            result = generateNumbers(total: 50, universe: 100)

        default:
            result = generateNumbers(total: 10, universe: 80)
            break
        }

        guard let result else { return [] }
        return result.sorted(by: { $0 < $1 } )
    }

    private func generateNumbers(total: Int, universe: Int) -> [Int] {
        guard let result else { return [] }
        var myGame: [Int] = result

        while myGame.count < total {
            let randomNumber = Int.random(in: 1...universe)
            if !myGame.contains(randomNumber) {
                myGame.append(randomNumber)
            }
        }
        return myGame.sorted()
    }

    func checkRemoteConfig() {
        let defaults: [String: NSObject] = [
            RemoteConfigValue.newUI.rawValue: false as NSObject
        ]
        remoteConfig.setDefaults(defaults)
        
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        self.remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success, error == nil {
                self.remoteConfig.activate { [weak self] _, error in
                    guard let self, error == nil else { return }
                    
                    let value = self.remoteConfig.configValue(forKey: RemoteConfigValue.newUI.rawValue).boolValue
                    DispatchQueue.main.async {
                        self.updateUI(value)
                    }
                }
            }
        }
    }
    
    private func updateUI(_ value: Bool) {
        delegate?.handleRemoteConfig(with: value)
    }
}

// MARK: - ONBOARDINGKIT DELEGATE
extension HomeViewModel: OnboardingKitDelegate {
    func didTapNextButton(at index: Int) {
        delegate?.didTapNextButton()
    }

    func didTapGetStarted() {
        delegate?.didTapGetStarted()
    }
}
