//
//  HapticManager.swift
//  CryptoTracker
//
//  Created by NJ Development on 22/06/24.
//

import Foundation
import SwiftUI

final class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
