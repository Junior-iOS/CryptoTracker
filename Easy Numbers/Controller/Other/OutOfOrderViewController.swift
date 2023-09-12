//
//  OutOfOrderViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 24/06/23.
//

import UIKit

class OutOfOrderViewController: UIViewController {
    private let outOfOrderView = OutOfOrderView()

    override func loadView() {
        super.loadView()
        self.view = outOfOrderView
    }
}
