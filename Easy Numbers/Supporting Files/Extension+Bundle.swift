//
//  Extension+Bundle.swift
//  Apple Music
//
//  Created by NJ Development on 11/05/23.
//

import Foundation

extension Bundle {
    var appName: String {
        return self.object(forInfoDictionaryKey: "APP_NAME") as! String
    }
}
