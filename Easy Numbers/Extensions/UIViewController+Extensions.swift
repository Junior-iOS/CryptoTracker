//
//  Extension+UIViewController.swift
//  Apple Music
//
//  Created by NJ Development on 11/05/23.
//

import Foundation
import UIKit

extension UIViewController {
    func defaultBackButton(target: Any? = nil, action: Selector? = nil) {
        let img = UIImage(systemName: "chevron.backward")
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: img,
                                                           style: .plain,
                                                           target: target ?? self.navigationController,
                                                           action: action ?? #selector(navigationController?.popViewController(animated:)))
    }
    
    func setupNavigation(actionFor leftBarButton: Selector?, actionFor rightBarButton: Selector) {
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: SFSymbol.infoCircleFill.image,
                                                           style: .done,
                                                           target: self,
                                                           action: leftBarButton)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbol.gear.image,
                                                            style: .done,
                                                            target: self,
                                                            action: rightBarButton)
    }
    
    func hideNavigationBar(_ status: Bool) {
        navigationController?.navigationBar.isHidden = status
    }
    
    func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    func checkforFaceID(_ coordinator: MainCoordinator) {
        let hasBiometrics = UserDefaults.standard.bool(forKey: "safetySwitch")
        let isHomeVC = self is HomeViewController
        
        if hasBiometrics {
            LocalAuthentication.shared.authenticateWithBiometrics { status in
                switch status {
                case .canNotEvaluate:
                    UserDefaults.standard.setValue(false, forKey: "safetySwitch")
                    let alert = UIAlertController(title: LocalizableStrings.faceIDDeniedAlertTitle.localized,
                                                  message: LocalizableStrings.faceIDDeniedAlertMessage.localized,
                                                  preferredStyle: .alert)
                    let no = UIAlertAction(title: LocalizableStrings.faceIDDeniedAlertButton.localized, style: .default)

                    alert.addAction(no)
                    self.present(alert, animated: true)
                case .canEvaluate:
                    if isHomeVC {
                        break
                    } else {
                        DispatchQueue.main.async {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                case .canEvaluateError:
                    if isHomeVC {
                        DispatchQueue.main.async {
                            coordinator.routeCheckFaceID()
                        }
                    } else {
                        break
                    }
                }
            }
        }
    }
}
