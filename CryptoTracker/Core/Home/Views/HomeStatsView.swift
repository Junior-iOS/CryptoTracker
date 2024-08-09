//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by NJ Development on 07/06/24.
//

import SwiftUI

struct HomeStatsView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var showPortfolio: Bool

    var body: some View {
        HStack {
            ForEach(homeViewModel.statistics) { statistic in
                StatisticView(stat: statistic)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(
            width: UIScreen.main.bounds.width,
            alignment: showPortfolio ? .trailing : .leading
        )
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.shared.homeVM)
}
