//
//  CoinDataService.swift
//  CryptoTracker
//
//  Created by NJ Development on 30/05/24.
//

import Combine
import Foundation

final class CoinDataService {
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    func getCoins() {
        guard let url = URL(
            string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=brl&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        ) else {
            return
        }

        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] coins in
                self?.allCoins = coins
                self?.coinSubscription?.cancel()
            })
    }
}
