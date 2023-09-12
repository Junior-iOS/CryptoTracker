//
//  NJFont.swift
//  Easy Numbers
//
//  Created by NJ Development on 24/06/23.
//

import Foundation
import UIKit

struct NJFont {
    static func regular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func bold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-Bold", size: size) ?? .systemFont(ofSize: size)
    }

    static func demibold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "AvenirNext-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
