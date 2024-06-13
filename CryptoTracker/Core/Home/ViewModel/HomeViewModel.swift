//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 30/05/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChange: -7)
    ]
    
    private var cancellables = Set<AnyCancellable>()
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        // MARK: Updates Coins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map { (text, startingCoins) -> [Coin] in
                guard !text.isEmpty else {
                    return startingCoins
                }
                
                let lowercasedText = text.lowercased()
                let filteredCoins = startingCoins.filter { coin in
                    return coin.id.lowercased().contains(lowercasedText) ||
                    coin.name.lowercased().contains(lowercasedText) ||
                    coin.symbol.lowercased().contains(lowercasedText)
                }
                
                return filteredCoins
            }
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        // MARK: Updates MarketData
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] stats in
                self?.statistics = stats
            }
            .store(in: &cancellables)
    }
    
    private func mapGlobalMarketData(_ marketData: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = Statistic(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolio = Statistic(title: "Portfolio Value", value: "R$ 0,00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        
        return stats
    }
}
