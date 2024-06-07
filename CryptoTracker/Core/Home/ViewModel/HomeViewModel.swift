//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by NJ Development on 30/05/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
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
    private let service = CoinDataService()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        //        service.$allCoins
        //            .sink { [weak self] coins in
        //                self?.allCoins = coins
        //            }
        //            .store(in: &cancellables)
        
        $searchText
            .combineLatest(service.$allCoins)
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
    }
}
