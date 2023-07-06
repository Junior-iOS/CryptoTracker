//
//  Snackbar.swift
//  Easy Numbers
//
//  Created by NJ Development on 06/07/23.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar

enum GameCopySave: String {
    case copy = "Jogo copiado"
    case save = "Jogo salvo"
}

final class SnackBar: NSObject {
    static func show(contextView: UIViewController, message: GameCopySave) {
        let mdcMessage = MDCSnackbarMessage()
        mdcMessage.text = message.rawValue
        mdcMessage.duration = 0.5
        
        MDCSnackbarManager.default.show(mdcMessage)
        MDCSnackbarManager.default.alignment = .center
           
        switch message {
        case .copy:
            MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = UIColor.systemGreen
        case .save:
            MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = UIColor.systemCyan
        }
    }
}
