//
//  SettingsViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
// https://apps.apple.com/br/app/jogos-lot%C3%A9rica/id6449045730

import Foundation
import MessageUI
import SafariServices
import StoreKit
import UIKit

protocol SettingsViewModelDelegate: AnyObject {
    func couldNotSentEmail(_ viewController: UIViewController)
    func shareApp(_ viewController: UIViewController)
}

final class SettingsViewModel {
    let navTitle = LocalizableStrings.settingsNavTitle.localized
    let sectionTitles = [LocalizableStrings.settingsSafetySectionTitle.localized,
//                                LocalizableStrings.settingsAccessibilitySectionTitle.localized, // UNDO
                                LocalizableStrings.settingsNotificationSectionTitle.localized,
                                LocalizableStrings.settingsVersionSectionTitle.localized]
    let rowTitles = [LocalizableStrings.settingsSafety.localized/*,
                            LocalizableStrings.settingsAccessibility.localized*/] // UNDO
    let notificationRowTitles = [LocalizableStrings.settingsNotificationTalkToUs.localized,
                                        LocalizableStrings.settingsNotificationShare.localized]

    private let kVersion = "CFBundleShortVersionString"

    weak var viewDelegate: SettingsViewModelDelegate?

    func appVersion() -> String {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary[kVersion] as? String else {
            return "Não encontrada"
        }
        return String(format: LocalizableStrings.settingsCurrentVersion.localized, "\(version)")
    }

    func numberOfSections() -> Int {
        sectionTitles.count
    }

    func numberOfRowsIn(_ section: Int) -> Int {
        // UNDO
//        return section == 2 ? 2 : 1
        return section == 1 ? 2 : 1
    }

    func sendEmail(delegate: UINavigationControllerDelegate, completion: (MFMailComposeViewController) -> Void) {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.delegate = delegate
            vc.setSubject(LocalizableStrings.settingsEmailSubject.localized)
            vc.setToRecipients([Bundle.main.njEmail])
            vc.setMessageBody(LocalizableStrings.settingsEmailBody.localized, isHTML: true)
            completion(vc)
        } else {
            guard let url = URL(string: Bundle.main.linkedIn) else { return }
            let vc = SFSafariViewController(url: url)
            viewDelegate?.couldNotSentEmail(vc)
        }
    }

    func shareApp() {
        guard let iTunesID = Int(Bundle.main.iTunesID) else { return }
//        let vc = SKStoreProductViewController()
//        vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber(value: iTunesID)])
//        viewDelegate?.shareApp(vc)

        DispatchQueue.main.async { [weak self] in
            let ac = UIActivityViewController(activityItems: ["https://apps.apple.com/br/app/jogos-lot%C3%A9rica/id\(iTunesID)"],
                                              applicationActivities: nil)

            if UIDevice.current.userInterfaceIdiom == .pad {
                let scenes = UIApplication.shared.connectedScenes

                guard let windowScene = scenes.first as? UIWindowScene,
                      let window = windowScene.windows.first else { return }

                ac.popoverPresentationController?.sourceView = window
                ac.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 300, height: 350)
                self?.viewDelegate?.shareApp(ac)
            } else {
                DispatchQueue.main.async {
                    self?.viewDelegate?.shareApp(ac)
                }
            }

            NJAnalytics.shared.trackEvent(name: .didShare, from: .settings)
        }
    }
}
