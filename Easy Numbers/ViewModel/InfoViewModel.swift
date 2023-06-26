//
//  InfoViewModel.swift
//  Easy Numbers
//
//  Created by NJ Development on 10/06/23.
//

import Foundation
import UIKit
import WebKit

final class InfoViewModel {
    func configureWebView(_ webView: WKWebView) {
        DispatchQueue.main.async {
            guard let url = URL(string: Bundle.main.resultsURL) else { return }
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
}
