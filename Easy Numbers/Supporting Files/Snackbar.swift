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
    
    var description: String {
        switch self {
        case .copy:
            LocalizableStrings.gamesGameCopied.localized
        case .save:
            LocalizableStrings.gamesGameSaved.localized
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .copy:
            UIColor.systemGreen
        case .save:
            UIColor.systemCyan
        }
    }
}

final class SnackBar: NSObject {
    static func show(contextView: UIViewController, type: GameCopySave) {
        let mdcMessage = MDCSnackbarMessage()
        mdcMessage.text = type.description
        mdcMessage.duration = 0.5

        MDCSnackbarManager.default.show(mdcMessage)
        MDCSnackbarManager.default.alignment = .center
        MDCSnackbarManager.default.snackbarMessageViewBackgroundColor = type.backgroundColor
    }
}
