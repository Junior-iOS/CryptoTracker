//
//  BaseViewController.swift
//  Easy Numbers
//
//  Created by Junior Silva on 17/05/23.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setGradientColor()
    }
}
