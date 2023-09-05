//
//  Snackbar.swift
//  Easy Numbers
//
//  Created by NJ Development on 06/07/23.
//

import Foundation
import MaterialComponents.MaterialSnackbar
import UIKit

enum GameCopySave {
    case copy
    case save
}

final class SnackBar: NSObject {
    static func show(contextView: UIViewController, message: GameCopySave) {
        let mdcMessage = MDCSnackbarMessage()
        mdcMessage.text = message == .save ? LocalizableStrings.gamesGameSaved.localized : LocalizableStrings.gamesGameCopied.localized
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
