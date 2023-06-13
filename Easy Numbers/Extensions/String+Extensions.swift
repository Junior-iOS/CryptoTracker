//
//  Extension+String.swift
//  Easy Numbers
//
//  Created by NJ Development on 23/05/23.
//

import Foundation

extension String {
    func removeBrackets() -> String {
        self.replacingOccurrences(of: "[", with: "")
            .replacingOccurrences(of: "]", with: "")
            .replacingOccurrences(of: ",", with: " ")
    }
}
