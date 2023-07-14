//
//  InfoViewController.swift
//  Easy Numbers
//
//  Created by NJ Development on 13/05/23.
//

import Foundation
import UIKit
import WebKit

class InfoViewController: BaseViewController {
    private let infoView = InfoView()
    private let viewModel: InfoViewModel

    override func loadView() {
        super.loadView()
        self.view = infoView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        addRightBarButton()
    }
    
    init(viewModel: InfoViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    private func addRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbol.houseCircle.image,
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didPressHome))
    }

    private func configureWebView() {
        DispatchQueue.main.async {
            self.viewModel.configureWebView(self.infoView.webView)
        }
    }

    @objc private func didPressHome() {
        configureWebView()
    }
}
