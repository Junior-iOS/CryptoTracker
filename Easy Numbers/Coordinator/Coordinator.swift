//
//  Coordinator.swift
//  Easy Numbers
//
//  Created by NJ Development on 10/06/23.
//

import Foundation
import UIKit

// MARK: - Coordinator
protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}
