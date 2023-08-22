//
//  SnackBar.swift
//  Easy Numbers
//
//  Created by NJ Development on 18/05/23.
//

import Foundation
import UIKit

enum RemoteConfigValue: String {
    case newUI = "shows_improvement_view"
}

enum SFSymbol: String {
    case infoCircleFill = "info.circle.fill"
    case houseCircle = "house.circle"
    case gear = "gearshape.circle.fill"
    case lock = "lock.circle.fill"
    
    var image: UIImage? {
        UIImage(systemName: rawValue)
    }
}
