//
//  SettingsViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
// https://apps.apple.com/br/app/jogos-lot%C3%A9rica/id6449045730

import Foundation
import UIKit
import MessageUI
import SafariServices
import StoreKit

protocol SettingsViewModelDelegate: AnyObject {
    func couldNotSentEmail(_ viewController: UIViewController)
    func shareApp(_ viewController: UIViewController)
}

final class SettingsViewModel {
    
    public let navTitle = "Ajustes"
    public let sectionTitles = ["SEGURANÇA", "ACESSIBILIDADE", "NOTIFICAÇÕES", "VERSÃO"]
    public let rowTitles = ["Face ID e Código", "Ativar acessibilidade"]
    public let notificationRowTitles = ["Fale Conosco", "Compartilhe"]
    
    private let kVersion = "CFBundleShortVersionString"
    private let kBuildNumber = "CFBundleVersion"
    
    weak var viewDelegate: SettingsViewModelDelegate?
    
    func appVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[kVersion] as! String
        let build = dictionary[kBuildNumber] as! String
        return "Versão atual: \(version)(\(build))"
    }
    
    public func numberOfSections() -> Int {
        return sectionTitles.count
    }
    
    public func numberOfRowsIn(_ section: Int) -> Int {
        return section == 2 ? 2 : 1
    }
    
    public func sendEmail(delegate: UINavigationControllerDelegate, completion: (MFMailComposeViewController) -> ()) {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.delegate = delegate
            vc.setSubject("Fale conosco / Dúvidas / Feedback - Jogos Lotérica")
            vc.setToRecipients([Bundle.main.njEmail])
            vc.setMessageBody("<h1>Olá, tudo bem?\n</h1>", isHTML: true)
            completion(vc)
        } else {
            guard let url = URL(string: Bundle.main.linkedIn) else { return }
            let vc = SFSafariViewController(url: url)
            viewDelegate?.couldNotSentEmail(vc)
        }
    }
    
    public func shareApp() {
        let vc = SKStoreProductViewController()
        vc.loadProduct(withParameters: [SKStoreProductParameterITunesItemIdentifier: NSNumber(value: 6449045730)])
        viewDelegate?.shareApp(vc)
    }
}
