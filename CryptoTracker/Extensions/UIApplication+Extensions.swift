//
//  UIApplication+Extensions.swift
//  CryptoTracker
//
//  Created by NJ Development on 01/06/24.
//

import Foundation
import SwiftUI

extension UIApplication {
    /// Dismiss the keyboard when clear button is pressed on a TextField
    /// ```
    /// ⓧ
    /// ```
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
