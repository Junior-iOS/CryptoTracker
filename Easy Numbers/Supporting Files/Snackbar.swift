//
//  Snackbar.swift
//  Easy Numbers
//
//  Created by NJ Development on 06/07/23.
//

import UIKit
import JGProgressHUD

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
    static func showHUD(in view: UIView, type: GameCopySave) {
        guard let image = type == .copy ? SFSymbol.plusCircleFill.image : SFSymbol.checkmarkCircleFill.image else { return }
        let hud = JGProgressHUD()
        hud.indicatorView = JGProgressHUDImageIndicatorView(image: image)
        hud.textLabel.text = type.description
        hud.hudView.backgroundColor = type.backgroundColor
        hud.show(in: view)
        hud.dismiss(afterDelay: 0.5)
    }
}
