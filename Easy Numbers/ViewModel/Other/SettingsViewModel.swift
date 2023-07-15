//
//  SettingsViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
//

import Foundation
import UIKit

final class SettingsViewModel {
    
    public let navTitle = "Ajustes"
    public let sectionTitles = ["SEGURANÇA", "ACESSIBILIDADE", "NOTIFICAÇÕES"]
    public let rowTitles = ["Face ID e Código", "Ativar acessibilidade"]
    public let notificationRowTitles = ["Fale Conosco", "Compartilhe"]
    
    public func numberOfRowsIn(_ section: Int) -> Int {
        return section == 2 ? 2 : 1
    }
}
