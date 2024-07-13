//
//  SettingsView.swift
//  CryptoTracker
//
//  Created by NJ Development on 13/07/24.
//

import SwiftUI

struct SettingsView: View {
    private let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel = SettingsViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            List {
                developerSection
                linkedinSection
                coinGeckoSection
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}

extension SettingsView {
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("developer")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed in SwiftUI. The project benefits from multi-threading, publisher/subscribers, and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit GitHub Page", destination: viewModel.githubURL)
        } header: {
            Text("Developer")
        }
    }
    
    private var linkedinSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("linked-in")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed in SwiftUI. The project benefits from multi-threading, publisher/subscribers, and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit LinkedIn Page", destination: viewModel.linkedinURL)
        } header: {
            Text("LinkedIn")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
//                            .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Text("The crypto currency data that is used in this app comes from a free API from CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("Visit CoinGecko", destination: viewModel.coingeckoURL)
        } header: {
            Text("CoinGecko")
        }
    }
}
