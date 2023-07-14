//
//  SettingsViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    private let viewModel: SettingsViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.navTitle
    }

}
