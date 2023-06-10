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
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        addRightBarButton()
    }
    
    private func addRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "house.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didPressHome))
    }
    
    @objc private func didPressHome() {
        configureWebView()
    }
    
    private func addComponents() {
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        
        setConstraints()
        configureWebView()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureWebView() {
        DispatchQueue.main.async {
            guard let url = URL(string: Bundle.main.resultsURL) else { return }
            self.webView.load(URLRequest(url: url))
            self.webView.allowsBackForwardNavigationGestures = true
        }
    }
}
