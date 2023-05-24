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
        String(describing: self)
    }
    
    func setGradientColor() {
        let gradientLayer = CAGradientLayer()
        let firstColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
        let secondColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.00)
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension Array {
    var isNotEmpty: Bool {
        !isEmpty
    }
    
    func contains<T>(obj: T) -> Bool where T: Equatable {
        !self.filter({ $0 as? T == obj }).isEmpty
    }
}
