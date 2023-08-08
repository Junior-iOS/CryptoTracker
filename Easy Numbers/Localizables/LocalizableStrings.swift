//
//  LocalizableStrings.swift
//  Easy Numbers
//
//  Created by NJ Development on 08/08/23.
//

import Foundation

enum LocalizableStrings: String {
    case homeSavedGames
    
    case settingsNavTitle
    case settingsSafetySectionTitle
    case settingsSafety
    
    case settingsAccessibilitySectionTitle
    case settingsAccessibility
    
    case settingsNotificationSectionTitle
    case settingsNotificationTalkToUs
    case settingsNotificationShare
    
    case settingsVersionSectionTitle
    case settingsCurrentVersion
    
    case gamesSaveButton
    case gamesGenerateAgain
    case gamesSavedGames
    
    case gamesGameSaved
    case gamesGameCopied
    
    case savedGamesNavTitle
    
    case savedGamesAlertTitle
    case savedGamesAlertMessage
    case savedGamesAlertNoButton
    case savedGamesAlertYesButton
    
    var localized: String {
        NSLocalizedString(String(describing: Self.self) + "_\(rawValue)", comment: "")
    }
}
