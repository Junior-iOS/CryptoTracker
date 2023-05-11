//
//  Extension+View.swift
//  Apple Music
//
//  Created by NJ Development on 11/05/23.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
