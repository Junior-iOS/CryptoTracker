//
//  DetailView.swift
//  CryptoTracker
//
//  Created by NJ Development on 27/06/24.
//

import SwiftUI

struct DetailLoadingView: View {
    @Binding var coin: Coin?

    init(coin: Binding<Coin?>) {
        self._coin = coin
    }

    var body: some View {
        ZStack {
            if let coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    @StateObject private var viewModel: DetailViewModel
    @State private var showFullDescription = false

    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    private let spacing: CGFloat = 30

    init(coin: Coin) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }

    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)

                VStack(spacing: 20) {
                    overviewTitle
                    Divider()

                    descriptionSection
                    overviewGrid
                    additionalTitle

                    Divider()
                    additionalGrid

                    Divider()
                    websiteSection
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

#Preview {
    NavigationView {
        DetailView(coin: DeveloperPreview.shared.coin)
    }
}

extension DetailView {
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
            .foregroundStyle(Color.theme.secondaryText)

            CoinImage(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }

    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var descriptionSection: some View {
        ZStack {
            if let description = viewModel.coinDescription, !description.isEmpty {
                VStack(alignment: .leading) {
                    Text(description)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)

                    Button(action: {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    }, label: {
                        Text(showFullDescription ? "Show less" : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
        )
    }

    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: [],
            content: {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
        )
    }

    private var websiteSection: some View {
        HStack {
            if let websiteString = viewModel.websiteURL,
               let url = URL(string: websiteString) {
                Link(destination: url, label: {
                    Text("Website")
                })
            }

            Spacer()

            if let redditString = viewModel.redditURL,
               let url = URL(string: redditString) {
                Link(destination: url, label: {
                    Text("Reddit")
                        .foregroundStyle(Color.theme.redditColor)
                })
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)
    }
}
