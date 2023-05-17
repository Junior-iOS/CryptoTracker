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
    
    func setGradientColor() {
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        let firstColor: UIColor = UIColor(red: 0.12, green: 0.12, blue: 0.12, alpha: 1.00)
        let secondColor: UIColor = UIColor(red: 0.22, green: 0.22, blue: 0.22, alpha: 1.00)
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0, 0.5, 1]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
