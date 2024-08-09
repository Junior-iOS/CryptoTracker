//
//  String+Extension.swift
//  CryptoTracker
//
//  Created by NJ Development on 11/07/24.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
