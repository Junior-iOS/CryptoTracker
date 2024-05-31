//
//  Double+Extensions.swift
//  CryptoTracker
//
//  Created by NJ Development on 30/05/24.
//

import Foundation

extension Double {
    
    /// Converts a Double into a Currency with 2 decimals places
    /// ```
    /// Convert 1234.56 to R$1.234,56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "brl"
        formatter.currencySymbol = "R$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Converts a Double into a Currency as String with 2 decimals places
    /// ```
    /// Convert 1234.56 to "R$1.234,56"
    /// ```
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "R$ 0,00"
    }
    
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1,2345 to "1,23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1,2345 to "1,23%"
    /// ```
    func asPercenbString() -> String {
        return asNumberString() + "%"
    }
}
