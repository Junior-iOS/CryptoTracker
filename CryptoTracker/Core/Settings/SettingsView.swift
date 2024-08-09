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
        SectionView(
            imageName: "developer",
            description: "This app was developed in SwiftUI. The project benefits from multi-threading, publisher/subscribers, and data persistance",
            linkText: "Visit GitHub Page",
            linkDestination: viewModel.githubURL,
            header: "Developer"
        )
    }
    
    private var linkedinSection: some View {
        SectionView(
            imageName: "linked-in",
            description: "This app was developed in SwiftUI. The project benefits from multi-threading, publisher/subscribers, and data persistance",
            linkText: "Visit LinkedIn Page",
            linkDestination: viewModel.linkedinURL,
            header: "LinkedIn"
        )
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                
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
