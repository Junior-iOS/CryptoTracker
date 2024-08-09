//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by NJ Development on 27/05/24.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var viewModel = HomeViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)
        }
    }
}
